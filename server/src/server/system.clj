(ns server.system
  (:require
    [com.stuartsierra.component :as c]
    [server.components.db :refer :all]
    [server.components.mom :refer :all]
    [server.components.lov :refer :all]
    [server.components.recommender :refer :all]
    [server.components.ring :refer :all]
    [server.components.logging :refer :all]
    )
  )

(defn new-system [db-opts app-fn ring-opts recommender-sparql log-config] 
  (c/system-map
    :log (c/using (new-logger log-config) [])
    :database (c/using (new-database db-opts) [:log])
    :mom (c/using (new-mom) [:log])
    :lov (c/using (new-lov) [:mom :database :log])
    :recommender (c/using (new-recommender recommender-sparql) [:mom :database :log])
    :ring (c/using (new-ring app-fn ring-opts) [:database :lov :recommender :log])
    )
  )
