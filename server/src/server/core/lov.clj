(ns server.core.lov
  (:require
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    [clojure.data.json :as json]
    [clj-http.client :as client]
    [taoensso.timbre :as timbre]
    [server.core.db :as db]
    )
  )
(timbre/refer-timbre)

(defn listen! [lov]
  (if @(:mom-adapter lov)
    (go-loop []
      (let [v (<! @(:mom-adapter lov))]
        (debug v)
        (if v (swap! (:recommender lov)
          (fn [m]
            (let [payload (dissoc v :topic)
                  _key (first (keys payload))
                  _val (get payload _key)]
              (assoc m _key _val)
              )
            )
          ))
        (if v (recur))
        )
      )
    )
  )

(defn type->type-uri [type]
  (case type
    :property "http://www.w3.org/1999/02/22-rdf-syntax-ns#Property"
    :class "http://www.w3.org/2000/01/rdf-schema#Class")
  )

(defn search [lov needle type-uri]
  (let [api (:search-api lov)
        response (client/get api {:query-params {:q needle :type type-uri}})
        json-data (json/read-str (:body response))
        results (get json-data "results")
        ]
    results
    )
  )

(defn search-property [lov needle]
  (search lov needle (type->type-uri :property))
  )

(defn search-class [lov needle]
  (search lov needle (type->type-uri :class))
  )

(defn filter-results [results]
  (let [filter-fn #(select-keys % ["score" "uri" "uriPrefixed" "vocabularyPrefix"]) ; "vocabulary" "types"
        filtered (map filter-fn results) 
        ]
    filtered
    )
  )

(defn update-entity! [lov table entity type]
  (debug lov table entity type)
  (go
    (let [queue (get-in lov [:mom :queue])
          type-uri (type->type-uri type)
          results (search lov entity type-uri)
          filtered (filter-results results)]
      (if filtered
        (>! @queue {:topic :lov [table entity type] filtered })
        )
      )
    )
  )

(defn update-recommender! 
  ([lov]
  (let [spec @(:spec (:database lov))
        tables (db/get-tables spec)]
    (doseq [i tables]
      (update-recommender! lov i)
      )
    ))

  ([lov table]
  (let [spec @(:spec (:database lov))
        columns (db/query-column-names spec table)]
    (doseq [i columns]
      (update-entity! lov table i :class) 
      (update-entity! lov table i :property) 
      )
    ))
  )
