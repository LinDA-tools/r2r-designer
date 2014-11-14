(ns server.system
  (:require
    [com.stuartsierra.component :as c]
    [server.components.datasource :refer :all]
    [server.components.oracle :refer :all]
    [server.components.ring :refer :all]
    [server.components.logging :refer :all]
    [server.routes.app :refer [app-fn]]))

(defn new-system [db-opts app-fn ring-opts oracle-sparql log-config] 
  (c/system-map
    :log (c/using (new-logger log-config) [])
    :datasource (c/using (new-datasource db-opts) [:log])
    :oracle (c/using (new-oracle oracle-sparql) [:datasource :log])
    :ring (c/using (new-ring app-fn ring-opts) [:datasource :oracle :log])))

(def log-config {
  :ns-whitelist []
  :ns-blacklist []})

(defn -main []
  (let [db-opts {:driver ""
                 :host ""
                 :name "" 
                 :username "" 
                 :password ""}
        ring-opts {:port 3000
                   :open-browser? false
                   :join true
                   :auto-reload? true}
        oracle-sparql "http://dbpedia.org/sparql"
        system (new-system 
                  db-opts 
                  #'app-fn 
                  ring-opts 
                  oracle-sparql 
                  log-config)]
    (c/start system)))
