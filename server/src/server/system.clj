(ns server.system
  (:require
    [com.stuartsierra.component :as c]
    [server.components.db :refer :all]
    [server.components.mom :refer :all]
    [server.components.lov :refer :all]
    [server.components.ring :refer :all]
    )
  )

(defn new-system [db-opts app-fn ring-opts] 
  (c/system-map
    :database (c/using (new-database db-opts) [])
    :mom (c/using (new-mom) [])
    :lov (c/using (new-lov) [:mom :database])
    :ring (c/using (new-ring app-fn ring-opts) [:database :lov])
    )
  )
