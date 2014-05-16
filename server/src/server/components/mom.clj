(ns server.components.mom
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.core.async :as async :refer [pub sub chan close!]]
    )
  )
(timbre/refer-timbre)

(defrecord MoM [queue publishers]
  c/Lifecycle

  (start [component]
    (info "starting MoM ...")
    (reset! queue (chan 20))
    (reset! publishers {})
    component
    )

  (stop [component]
    (info "stopping MoM ...")
    (if @queue
      (close! @queue)
      (reset! queue nil))
    (reset! publishers nil)
    component
    )
  )
  
(defn new-mom  []
  (map->MoM {:queue (atom nil) 
             :publishers (atom nil)
             }) 
  )


