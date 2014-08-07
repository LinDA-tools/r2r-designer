(ns dev
  "Tools for interactive development with the REPL. This file should
   not be included in a production build of the application."
  (:require
    [clojure.java.io :as io]
    [clojure.java.javadoc :refer (javadoc)]
    [clojure.java.jdbc :as jdbc]
    [clojure.pprint :refer (pprint)]
    [clojure.reflect :refer (reflect)]
    [clojure.repl :refer (apropos dir doc find-doc pst source)]
    [clojure.string :as string]
    [clojure.test :as test]
    [clojure.tools.namespace.repl :refer (refresh refresh-all)]
    [clojure.tools.reader.edn :as edn]
    [clojure.set :refer :all]
    [clojure.java.classpath :refer :all]
    [clojure.data.json :as json]
    [com.stuartsierra.component :as c]
    [ring.server.standalone :refer :all]
    [ring.middleware.file-info :refer :all]
    [ring.middleware.file :refer :all]
    [clj-http.client :as client]
    [edu.ucdenver.ccp.kr.kb :refer :all]
    [edu.ucdenver.ccp.kr.rdf :refer :all]
    [edu.ucdenver.ccp.kr.sparql :refer :all]
    [edu.ucdenver.ccp.kr.sesame.kb :as sesame]
    [taoensso.timbre :as timbre]
    [server.components.db :refer :all]
    [server.components.oracle :refer :all]
    [server.components.ring :refer :all]
    [server.core.db :refer :all]
    [server.core.oracle :refer :all]
    [server.routes.app :refer [app-fn]]
    [server.system :refer [new-system]]
    )
  )

(timbre/refer-timbre)

(def system
  "A Var containing an object representing the application under
  development."
  nil)

(def log-config {
  :ns-whitelist []
  :ns-blacklist []
  })

(defn init
  "Creates and initializes the system under development in the Var
  #'system."
  []
  (let [db-opts {:classname "org.postgresql.Driver"
                 :subprotocol "postgresql" 
                 :subname "mydb" 
                 :username "postgres" 
                 :password ""}
        ring-opts {:port 3000
                   :open-browser? false
                   :join true
                   :auto-reload? true}
        oracle-sparql "http://dbpedia.org/sparql"]
    (alter-var-root #'system (constantly (new-system db-opts #'app-fn ring-opts oracle-sparql log-config)))
    )
  )

(defn start
  "Starts the system running, updates the Var #'system."
  []
  (alter-var-root #'system c/start)
  )

(defn stop
  "Stops the system if it is currently running, updates the Var
  #'system."
  []
  (alter-var-root #'system
    (fn [s] (when s (c/stop s))))
  )

(defn go
  "Initializes and starts the system running."
  []
  (init)
  (start)
  :ready)

(defn reset
  "Stops the system, reloads modified source files, and restarts it."
  []
  (stop)
  (refresh :after 'dev/go))

;; (defn -main [& args] (dev/go))
