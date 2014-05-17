(ns server.components.db
  (:require
    [taoensso.timbre :as timbre]
    [com.stuartsierra.component :as c]
    [server.core.db :refer [new-pool]]
    )
  )
(timbre/refer-timbre)

(defrecord Database [spec pool conn]
  c/Lifecycle

  (start [component]
    (info "starting database adapter ...")
    (reset! (:pool component) (new-pool component))
    component
    )

  (stop [component]
    (info "stopping database adapter ...")
    (if @(:pool component)
      (reset! (:pool component) nil))
    component
    )
  )
  
(defn new-database [opts]
  (map->Database {:spec (atom (select-keys opts [:classname :subprotocol :subname :username :password]))
                  :pool (atom nil)
                  :min-pool 0
                  :max-pool 15
                  :partitions 3})
  )
