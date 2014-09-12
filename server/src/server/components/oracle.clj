(ns server.components.oracle
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [server.core.oracle :refer :all]
    )
  )
(timbre/refer-timbre)

(defrecord Oracle [kb endpoint sample threshold limit n]
  c/Lifecycle

  (start [component]
    (info "starting oracle ...")
    (reset! (:kb component) 
            (new-server (:endpoint component)))
    component
    )

  (stop [component]
    (info "stopping oracle ...")
    (reset! (:kb component) nil)
    component
    )
  )
  
(defn new-oracle [endpoint]
  (map->Oracle {:endpoint endpoint
                :kb (atom nil)
                :sample 20
                :threshold 0
                :limit 20
                :n 10
                }) 
  )
