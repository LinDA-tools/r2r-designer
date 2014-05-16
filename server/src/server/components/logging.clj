(ns server.components.logging
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    )
  )
(timbre/refer-timbre)

(defrecord Logger [config]
  c/Lifecycle

  (start [component]
    (info "start logging ...")
    (timbre/merge-config! config)
    component
    )

  (stop [component]
    (info "stop logging ...")
    component
    )
  )
  
(defn new-logger [config]
  (map->Logger {:config config})
  )
