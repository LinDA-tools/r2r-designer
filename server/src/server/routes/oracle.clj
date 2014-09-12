(ns server.routes.oracle
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [clojure.set :refer :all]
    [ring.util.codec :as codec]
<<<<<<< HEAD
    [server.core.db :as db]
    [server.core.oracle :refer :all]
    )
  )

(timbre/refer-timbre)

(defn oracle-routes-fn [component]
  (let [api (:oracle-api component)]
    (defroutes oracle-routes
      (POST (str api "/suggest") request
        (let [oracle (:oracle component)
              response nil]
          (str request)))
      (GET (str api "/properties/search") [q :as r] 
        (let [oracle (:oracle component)
              response nil]
          response))
      (GET (str api "/classes/search") [q :as r] 
        (let [oracle (:oracle component)
              response nil]
          response))
      )
    )
  )


=======
    [clojure.data.json :as json]
    [server.core.db :as db]
    [server.core.oracle :refer :all]))

(timbre/refer-timbre)

(defn oracle-routes-fn [c]
  (let [api (:oracle-api c)]
    (defroutes oracle-routes
      (POST (str api) [_ :as r]
        (let [oracle (:oracle c)
              table (:body r)
              response (recommend oracle (:name table) (:columns table))]
          (json/write-str response)))

      (GET (str api "/properties") [q :as r] 
        (let [oracle (:oracle c)
              response (search-properties oracle q)]
          (json/write-str response)))

      (GET (str api "/classes") [q :as r] 
        (let [oracle (:oracle c)
              response (search-classes oracle q)]
          (json/write-str response))))))
>>>>>>> server
