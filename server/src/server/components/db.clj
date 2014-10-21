(ns server.components.db
  (:require
    [taoensso.timbre :as timbre]
    [com.stuartsierra.component :as c]
    [server.core.db :refer [new-datasource]]))

(timbre/refer-timbre)

(defrecord Database [spec datasource]
  c/Lifecycle

  (start [c]
    (info "starting database adapter ...")
    (reset! (:datasource c) (new-datasource c))
    c)

  (stop [c]
    (info "stopping database adapter ...")
    (when (:datasource c) 
      (if @(:datasource c) (.close @(:datasource c)))
      (reset! (:datasource c) nil))
    c))
  
(defn new-database [opts]
  (map->Database {:spec (atom (select-keys opts [:driver :host :name :username :password]))
                  :datasource (atom nil)
                  :max-pool 10}))
