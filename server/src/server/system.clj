(ns server.system)

(def db-spec {
    :subprotocol "hsqldb" 
    :subname "jdbc:mem:sample-db" 
    :user "SA" 
    :password ""
    }
  )

(defn system []
  {:db db-spec :server (atom nil)}
  )
