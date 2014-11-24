(ns server.components.sparqlify
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [server.core.sparqlify :refer :all]))

(timbre/refer-timbre)

(defrecord Sparqlify [port]
  c/Lifecycle

  (start [component]
    (info "starting sparqlify ...")
    component) 

  (stop [component]
    (info "stopping sparqlify ...")
    component))
  
(defn new-sparqlify [port]
  (map->Sparqlify {:port port}))
