(ns server.components.sparqlify
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [server.core.sparqlify :refer :all]))

(timbre/refer-timbre)

(defrecord Sparqlify [host port server]
  c/Lifecycle

  (start [c]
    (info "starting sparqlify ...")
    (when (:server c) 
      (if @(:server c) (.start @(:server c))))
    c) 

  (stop [c]
    (info "stopping sparqlify ...")
    (when (:server c) 
      (if @(:server c) (.stop @(:server c)))
      (reset! (:server c) nil))
    c))
  
(defn new-sparqlify [opts]
  (map->Sparqlify {:host (:host opts)
                   :port (:port opts)
                   :server (atom nil)}))
