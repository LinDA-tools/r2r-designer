(ns server.routes.recommender
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [clojure.set :refer :all]
    [ring.util.codec :as codec]
    [server.core.db :as db]
    [server.core.recommender :refer :all]
    )
  )
(timbre/refer-timbre)

(defn recommender-routes-fn [component]
  (let [api (:recommender-api component)]
    (defroutes recommender-routes
      (GET (str api "/types") [table template :as r] (do
        (debug r)
        (let [db @(:spec (:database component))
              all-columns (into #{} (db/query-column-names db table))
              template-decoded (codec/url-decode template)
              template-columns (into #{} (db/parse-columns template-decoded))
              columns (intersection all-columns template-columns)
              suggestions (for [column columns] (recommend-for-column (:recommender component) table column))
              response (str (or (seq (apply concat suggestions)) []))]
          (debug response)
          response
          )
        ))
      )
    )
  )


