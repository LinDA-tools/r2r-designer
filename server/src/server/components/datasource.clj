(ns server.components.datasource
  (:require
    [taoensso.timbre :as timbre]
    [com.stuartsierra.component :as c]
    [server.core.db :refer [new-pool]]))

(timbre/refer-timbre)

(defrecord Datasource [spec pool]
  c/Lifecycle

  (start [c]
    (info "starting database adapter ...")
    (reset! (:pool c) (new-pool c))
    c)

  (stop [c]
    (info "stopping database adapter ...")
    (when (:pool c) 
      (if @(:pool c) (.close @(:pool c)))
      (reset! (:pool c) nil))
    c))
  
(defn new-datasource [opts]
  (map->Datasource {:spec (atom (select-keys opts [:driver :host :name :username :password]))
                    :pool (atom nil)
                    :max-pool 100}))
