(ns server.system)

(def db-spec {
    :subprotocol "postgresql" 
    :subname "mydb" 
    :user "postgres" 
    :password ""
    }
  )

(defn system []
  {:db db-spec :server (atom nil)}
  )
