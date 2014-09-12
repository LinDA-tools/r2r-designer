(ns server.components.ring
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [server.routes.app :refer [app-fn]]
    [ring.server.standalone :refer [serve]]
    )
  )
(timbre/refer-timbre)

(defrecord Ring [server app-fn opts db-api oracle-api]
  c/Lifecycle

  (start [component] 
    (info "starting ring adapter ...")
    (let [app (app-fn component)]
      (reset! server (serve app opts))
      component
      )
    )

  (stop [component] 
    (info "stopping ring adapter ...") 
    (if @server
      (.stop @server)
      (reset! server nil))
    component
    )
  )

(defn new-ring [app-fn opts]
  (map->Ring {:opts opts 
              :server (atom nil) 
              :app-fn app-fn
              :db-api "/api/v1/db"
              :oracle-api "/api/v1/oracle"})
  )
