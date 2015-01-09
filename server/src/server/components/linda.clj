(ns server.components.linda
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [server.core.linda :refer :all])
  )

(timbre/refer-timbre)

(defrecord Linda []
  c/Lifecycle

  (start [c]
    (info "starting linda adapter ...")
    c) 

  (stop [c]
    (info "stopping linda adapter ...")
    c))
  
(defn new-linda [opts]
  (map->Linda {:host (:host opts)}))
