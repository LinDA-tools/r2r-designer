(ns server.core.lov
  (:require
    [clojure.tools.logging :refer (info warn error debug)]
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    [clj-http.client :as client]
    [clojure.data.json :as json]
    )
  )

(def host "http://lov.okfn.org/dataset/lov")
(def api "/api/v1/search")

(defn search [needle type]
  (let [response (client/get (str host api) {:query-params {:q needle :type type}})
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

(defn search-property [needle]
  (search needle "http://www.w3.org/1999/02/22-rdf-syntax-ns#Property")
  )

(defn search-class [needle]
  (search needle "http://www.w3.org/2000/01/rdf-schema#Class")
  )
