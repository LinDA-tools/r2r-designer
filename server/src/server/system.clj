(ns server.system
  (:require
    [taoensso.timbre :as timbre]
    [com.stuartsierra.component :as c]
    [server.components.datasource :refer :all]
    [server.components.oracle :refer :all]
    [server.components.sparqlify :refer :all]
    [server.components.ring :refer :all]
    [server.components.logging :refer :all]
    [server.routes.app :refer [app-fn]])
  (:gen-class))

(timbre/refer-timbre)

(defn new-system [db-opts app-fn ring-opts oracle-sparql-endpoint log-config sparqlify-opts] 
  (c/system-map
    :log (c/using (new-logger log-config) [])
    :datasource (c/using (new-datasource db-opts) [:log])
    :oracle (c/using (new-oracle oracle-sparql-endpoint) [:datasource :log])
    :sparqlify (c/using (new-sparqlify sparqlify-opts) [:datasource :log])
    :ring (c/using (new-ring app-fn ring-opts) [:datasource :oracle :sparqlify :log])
    ))

;; configuration options

(def log-config {:ns-whitelist [] 
                 :ns-blacklist []})

(def db-opts {:driver "" 
              :host "" 
              :name "" 
              :username "" 
              :password ""}) 

(def ring-opts {:port 3000 
                :open-browser? false 
                :join true 
                :auto-reload? true})

(def oracle-sparql-endpoint "http://dbpedia.org/sparql")

(def sparqlify-opts {:host "http://localhost"
                     :port 7531}) 

(def system (atom (new-system 
                    db-opts 
                    #'app-fn 
                    ring-opts 
                    oracle-sparql-endpoint 
                    log-config 
                    sparqlify-opts)))

(def app (app-fn @system))
 
(defn init 
  "called when web app is initialized"
  []
  (info "init r2r-designer/server.system")
  (info "before: " @system)
  (when @system (swap! system c/start))
  (info "after: " @system)
  )

(defn destroy 
  "called when web app is destroyed"
  []
  (info "destroy r2r-designer/server.system")
  (when @system (swap! system c/stop)))

;; configure new system and start it
(defn -main []
  (info "calling server.system/-main")
  (init))
