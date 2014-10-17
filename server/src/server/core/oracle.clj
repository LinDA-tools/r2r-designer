(ns server.core.oracle
  (:require
    [clojure.data.json :as json]
    [clojure.string :refer [join split]]
    [clj-http.client :as client]
    [edu.ucdenver.ccp.kr.kb :refer :all]
    [edu.ucdenver.ccp.kr.rdf :refer :all]
    [edu.ucdenver.ccp.kr.sparql :refer :all]
    [edu.ucdenver.ccp.kr.sesame.kb :as sesame]
    [taoensso.timbre :as timbre]
    [server.core.db :as db]))

(timbre/refer-timbre)

(defn new-server [endpoint]
  (open 
    (sesame/new-sesame-server
      :server endpoint
      :repo-name "")))

(defn add-namespaces [kb]
  (update-namespaces kb
   '(("rdf" "http://www.w3.org/1999/02/22-rdf-syntax-ns#")
     ("rdfs" "http://www.w3.org/2000/01/rdf-schema#")
     ("dcterms" "http://purl.org/dc/terms/")
     ("skos" "http://www.w3.org/2004/02/skos/core#")
     )))

(defn get-label [c entity]
  (let [kb (add-namespaces @(:kb c))]
    (let [result (sparql-query kb (format "select distinct * where { <%s> <http://www.w3.org/2000/01/rdf-schema#label> ?x. } limit 1" entity))]
      (map '?/x result))))

(defn get-comment [c entity]
  (let [kb (add-namespaces @(:kb c))]
    (let [result (sparql-query kb (format "select distinct * where { <%s> <http://www.w3.org/2000/01/rdf-schema#comment> ?x. } limit 1" entity))]
      (map '?/x result))))

(defn get-title [c entity]
  (let [kb (add-namespaces @(:kb c))]
    (let [result (sparql-query kb (format "select distinct * where { <%s> <http://purl.org/dc/terms/title> ?x. } limit 1" entity))]
      (map '?/x result))))

(defn get-description [c entity]
  (let [kb (add-namespaces @(:kb c))]
    (let [result (sparql-query kb (format "select distinct * where { <%s> <http://purl.org/dc/terms/description> ?x. } limit 1" entity))]
      (map '?/x result))))

(defn get-definition [c entity]
  (let [kb (add-namespaces @(:kb c))]
    (let [result (sparql-query kb (format "select distinct * where { <%s> <http://www.w3.org/2004/02/skos/core#definition> ?x. } limit 1" entity))]
      (map '?/x result))))

(defn significant [c results]
  (filter #(> (:score %) (:threshold c)) results))

(defn cut [c results]
  (take (:n c) results))

(defn shaped [results]
  (let [filter-fn #(select-keys % [:score :uri :prefixedName :vocabulary.prefix])
        filtered (map filter-fn results)]
    filtered))

(defn transform [entity-map]
  (let [prefixedName (first (:prefixedName entity-map))
        vocabPrefix (first (:vocabulary.prefix entity-map))
        localName (if (and prefixedName vocabPrefix) (subs prefixedName (inc (.length vocabPrefix))))
        uri (first (:uri entity-map))
        vocab (if (and uri localName) (subs uri 0 (- (.length uri) (.length localName))))]
    (assoc entity-map
           :localName (if localName [localName] [])
           :vocabulary.uri (if vocab [vocab] []))))

(defn enrich [c entity-map]
  (let [uri (first (:uri entity-map))
        vocab (first (:vocabulary.uri entity-map))]
    (assoc entity-map 
           :label (get-label c uri)
           :comment (get-comment c uri)
           :definition (get-definition c uri)
           :vocabulary.title (get-title c vocab)
           :vocabulary.description (get-description c vocab)
           )))

(defn query-lov [c type query]
  (if (and c query (seq query))
    (let [api "http://lov.okfn.org/dataset/lov/api/v2/search"
          results (-> (client/get api {:query-params {:q query :type type}}) :body json/read-json :results)]
      results)
    []))

(defn process [c raw]
  (let [outer (->> raw 
                  (significant c)
                  (cut c)
                  shaped)
        inner (map (comp #(enrich c %) transform) outer)]
    inner))

(defn expr->items [expr] (filter seq (split expr #"[\s,;]+")))

(defn search-classes [c expr]
  (process c (apply concat (map #(query-lov c "class" %) (expr->items expr)))))

(defn search-properties [c expr]
  (process c (apply concat (map #(query-lov c "property" %) (expr->items expr)))))

(defn item-or-tag [item tag] (if (empty? tag) item tag))

(defn recommend [c table columns]
  (let [t-rec {:name (:name table) 
               :recommend (search-classes c (item-or-tag (:name table) (:tag table)))}
        c-rec (for [i columns] 
                {:name (:name i) 
                 :recommend (search-properties c (item-or-tag (:name i) (:tag i)))})]
    {:table t-rec :columns c-rec}))

;;;;

(defn uri->result [uri]
  {"uri" (str uri)})

(defn find-types [c label limit]
  (let [kb (add-namespaces @(:kb c))]
    (binding [*select-limit* limit
              *select-type* select-distinct]
      (let [var-uris (query kb `((?/s rdfs/label ~(cond (string? label) (str label) 
                                                        (number? label) (int label)))
                             (?/s rdf/type ?/t)))
            uris (map '?/t var-uris) 
            result (map uri->result uris)]
        result))))

(defn merge-results [resultset threshold n]
  (let [indexed (map #(zipmap % (repeat 1)) resultset)
        merged (apply merge-with + indexed)
        sequenced (seq merged)
        filtered (filter #(<= threshold (second %)) sequenced)
        sorted (sort-by second > filtered)
        cut (take n sorted)
        result (map first cut)]
    result))

(defn recommend-types [c labels limit threshold n]
  (let [results (map #(find-types c % limit) labels)
        merged (merge-results results threshold n)]
    merged))

(defn recommend-for-column [c table column]
  (let [data (db/query-column @(:spec (:database c)) table column)
        sample-data (take (:sample c) data)
        result (recommend-types c sample-data (:limit c) (:threshold c) (:n c))]
    result))
