(ns server.components.lov
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.core.async :as async :refer [pub sub chan close!]]
    [server.core.lov :refer :all]
    )
  )
(timbre/refer-timbre)

(defrecord LOV [recommender mom-adapter search-api autocomplete-api]
  c/Lifecycle

  (start [component]
    (info "starting LOV adapter ...")
    (reset! mom-adapter (chan 10))
    (let [mom (:mom component)
          publishers (:publishers mom)]
      (if-not (:lov @publishers)
        (swap! publishers #(assoc % :lov (pub @(:queue mom) :topic)))
        )
      (sub (:lov @publishers) :lov @mom-adapter)
      )
    (listen! component)
    component
    )

  (stop [component]
    (info "stopping LOV adapter ...")
    (reset! (:recommender component) {})
    (if @mom-adapter
      (close! @mom-adapter)
      (reset! mom-adapter nil))
    component
    )
  )
  
(defn new-lov []
  (map->LOV {:search-api "http://lov.okfn.org/dataset/lov/api/v1/search"
             :autocomplete-api "http://lov.okfn.org/dataset/lov/api/v2/autocomplete"
             :recommender (atom {})
             :mom-adapter (atom nil)
             }) 
  )