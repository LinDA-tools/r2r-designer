(ns server.core.lov
  (:require
    [clojure.tools.logging :refer (info warn error debug)]
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    [clj-http.client :as client]
    [clojure.data.json :as json]
    )
  )

(defn listen! [lov]
  (go-loop []
    (if @(:mom-adapter lov)
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
      )
    (recur)
    )
  )

(defn search [lov needle type]
  (let [api (:search-api lov)
        response (client/get api {:query-params {:q needle :type type}})
        json-data (json/read-str (:body response))
        results (get json-data "results")
        ]
    results
    )
  )

(defn filter-results [results]
  (let [filter-fn #(select-keys % ["score" "uri" "uriPrefixed"]) ; "vocabulary" "types"
        filtered (map filter-fn results) 
        ]
    filtered
    )
  )

(defn search-property [lov needle]
  (search lov needle "http://www.w3.org/1999/02/22-rdf-syntax-ns#Property")
  )

(defn search-class [lov needle]
  (search lov needle "http://www.w3.org/2000/01/rdf-schema#Class")
  )
