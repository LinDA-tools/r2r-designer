(ns server.components.recommender
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.core.async :as async :refer [pub sub chan close!]]
    [server.core.recommender :refer :all]
    )
  )
(timbre/refer-timbre)

(defrecord Recommender [kb mom-adapter endpoint sample threshold limit n]
  c/Lifecycle

  (start [component]
    (info "starting Recommender ...")
    (reset! (:kb component) 
            (new-server (:endpoint component)))
    ;; (reset! mom-adapter (chan 10))
    ;; (let [mom (:mom component)
    ;;       publishers (:publishers mom)]
    ;;   (if-not (:recommender @publishers)
    ;;     (swap! publishers #(assoc % :recommender (pub @(:queue mom) :topic)))
    ;;     )
    ;;   (sub (:recommender @publishers) :recommender @mom-adapter)
    ;;   )
    ;; (listen! component)
    component
    )

  (stop [component]
    (info "stopping Recommender ...")
    (reset! (:kb component) nil)
    ;; (if @mom-adapter
    ;;   (close! @mom-adapter)
    ;;   (reset! mom-adapter nil))
    component
    )
  )
  
(defn new-recommender [endpoint]
  (map->Recommender {:endpoint endpoint
                     :kb (atom nil)
                     :mom-adapter (atom nil)
                     :sample 20
                     :threshold 0
                     :limit 20
                     :n 10
                     }) 
  )
