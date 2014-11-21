(ns server.system
  (:require
    [com.stuartsierra.component :as c]
    [server.components.datasource :refer :all]
    [server.components.oracle :refer :all]
    [server.components.sparqlify :refer :all]
    [server.components.ring :refer :all]
    [server.components.logging :refer :all]
    [server.routes.app :refer [app-fn]]))

(defn new-system [db-opts app-fn ring-opts oracle-sparql-endpoint log-config] 
  (c/system-map
    :log (c/using (new-logger log-config) [])
    :datasource (c/using (new-datasource db-opts) [:log])
    :oracle (c/using (new-oracle oracle-sparql-endpoint) [:datasource :log])
    :sparqlify (c/using (new-sparqlify) [:datasource :log])
    :ring (c/using (new-ring app-fn ring-opts) [:datasource :oracle :sparqlify :log])))

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

;; configure new system and start it
(defn -main []
  (let [system (new-system 
                  db-opts 
                  #'app-fn 
                  ring-opts 
                  oracle-sparql-endpoint 
                  log-config)]
    (c/start system)))
