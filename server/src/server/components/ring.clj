(ns server.components.ring
  (:require
    [clojure.tools.logging :refer (info warn error debug)]
    [com.stuartsierra.component :as c]
    [server.routes.app :refer [app-fn]]
    [ring.server.standalone :refer [serve]]
    )
  )

(defrecord Ring [server app-fn opts db-api lov-api]
  c/Lifecycle

  (start [component] 
    (println "starting ring adapter ...")
    (let [app (app-fn component)]
      (reset! server (serve app opts))
      component
      )
    )

  (stop [component] 
    (println "stopping ring adapter ...") 
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
              :lov-api "/api/v1/lov"})
  )
