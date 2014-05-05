(ns server.routes.lov
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    [server.core.lov :refer :all]
    )
  )

(defn lov-routes-fn [component]
  (let [api (:lov-api component)
        recommender (:recommender (:lov component))]
    (defroutes lov-routes
      (GET (str api "/properties") [column :as r] (do
        (debug r)
        (let [suggestions (get @recommender [column :property])]
          (str (or (seq suggestions))
                   [])
          )
        ))
      (GET (str api "/classes") [column :as r] (do
        (debug r)
        (let [suggestions (get @recommender [column :class])]
          (str (or (seq suggestions)
                   []))
          )
        ))
      )
    )
  )

