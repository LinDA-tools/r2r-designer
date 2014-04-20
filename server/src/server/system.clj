(ns server.system
  (:require
    [clojure.core.async :as async :refer [go go-loop chan timeout <! >! <!! >!! alts! alts!! alt! alt!!]]
    )
  )

(def db-spec {
    :subprotocol "postgresql" 
    :subname "mydb" 
    :user "postgres" 
    :password ""
    }
  )

(defn system [] {
  :db db-spec 
  :server (atom nil)
  :mom (atom nil)
  :publishers (atom nil) 
  :lov {
    :recommender (atom {})
    :mom-adapter (atom nil)
    }
  })
