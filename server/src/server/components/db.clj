(ns server.components.db
  (:require
    [taoensso.timbre :as timbre]
    [com.stuartsierra.component :as c]
    )
  )
(timbre/refer-timbre)

(defrecord Database [spec]
  c/Lifecycle

  (start [component]
    (info "starting database adapter ...")
    component
    )

  (stop [component]
    (info "stopping database adapter ...")
    component
    )
  )
  
(defn new-database [opts]
  (map->Database {:spec (atom (select-keys opts [:subprotocol :subname :username :password]))})
  )
