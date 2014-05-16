(ns server.core.recommender
  (:require
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    [clojure.data.json :as json]
    [clojure.string :refer [join]]
    [clj-http.client :as client]
    [edu.ucdenver.ccp.kr.kb :refer :all]
    [edu.ucdenver.ccp.kr.rdf :refer :all]
    [edu.ucdenver.ccp.kr.sparql :refer :all]
    [edu.ucdenver.ccp.kr.sesame.kb :as sesame]
    [taoensso.timbre :as timbre]
    [server.core.db :as db]
    )
  )
(timbre/refer-timbre)

(defn listen! [recommender]
  (if @(:mom-adapter recommender)
    (go-loop []
      (let [v (<! @(:mom-adapter recommender))]
        ;do nothing 
        (if v (recur))
        )
      )
    )
  )

(defn new-server [endpoint]
  (open 
    (sesame/new-sesame-server
      :server endpoint
      :repo-name "")
    )
  )

(defn add-namespaces [kb]
  (update-namespaces kb
   '(("rdf" "http://www.w3.org/1999/02/22-rdf-syntax-ns#")
     ("rdfs" "http://www.w3.org/2000/01/rdf-schema#")))
  )

(defn uri->result [uri]
  {"uri" (str uri)}
  )

(defn find-types [c label limit]
  (let [kb (add-namespaces @(:kb c))]
    (binding [*select-limit* limit
              *select-type* select-distinct]
      (let [var-uris (query kb `((?/s rdfs/label ~(cond (string? label) (str label) 
                                                        (number? label) (int label)))
                             (?/s rdf/type ?/t)))
            uris (map '?/t var-uris) 
            result (map uri->result uris)]
        result
        )
      )
    )
  )

(defn merge-results [resultset threshold n]
  (let [indexed (map #(zipmap % (repeat 1)) resultset)
        merged (apply merge-with + indexed)
        sequenced (seq merged)
        filtered (filter #(<= threshold (second %)) sequenced)
        sorted (sort-by second > filtered)
        cut (take n sorted)
        result (map first cut)]
    result
    )
  )

(defn recommend-types [c labels limit threshold n]
  (let [results (map #(find-types c % limit) labels)
        merged (merge-results results threshold n)]
    merged
    )
  )

(defn recommend-for-column [c table column]
  (let [data (db/query-column @(:spec (:database c)) table column)
        sample-data (take (:sample c) data)
        result (recommend-types c sample-data (:limit c) (:threshold c) (:n c))]
    result
    )
  )
