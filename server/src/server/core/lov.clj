(ns server.core.lov
  (:require
    [clojure.data.json :as json]
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    [clj-http.client :as client]
    [server.system :as system]
    )
  )

(def host "http://lov.okfn.org/dataset/lov")
(def search-api "/api/v1/search")
(def autocomplete-api "/api/v2/autocomplete/")

(defn listen! [lov]
  (go-loop []
    (let [v (<! @(:mom-adapter lov))]
      (if v (swap! (:recommender lov) 
        (fn [m] 
          (let [payload (dissoc v :topic)
                _key (first (keys payload))
                _val (get payload _key)]
            (assoc m _key _val)
            )
          )
        ))
      )
    (recur)
    )
  )

(def search (memoize (fn [needle type]
  (let [response (client/get (str host search-api) {:query-params {:q needle :type type}})
        json-data (json/read-str (:body response))
        results (get json-data "results")
        ]
    results
    )))
  )

(defn update-recommender! [lov entity type]
  (go
    (let [result (search entity type)]
      (>! @(:mom-adapter lov) result) 
      )
    )
  )

(defn filter-results [results]
  (let [filter-fn #(select-keys % ["score" "uri" "uriPrefixed"]) ; "vocabulary" "types"
        filtered (map filter-fn results) 
        ]
    filtered
    )
  )

(defn search-property [needle]
  (search needle "http://www.w3.org/1999/02/22-rdf-syntax-ns#Property")
  )

(defn search-class [needle]
  (search needle "http://www.w3.org/2000/01/rdf-schema#Class")
  )
