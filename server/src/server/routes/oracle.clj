(ns server.routes.oracle
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [clojure.set :refer :all]
    [ring.util.codec :as codec]
    [ring.util.response :refer [response]]
    [clojure.data.json :as json]
    [server.core.db :as db]
    [server.core.oracle :refer :all]
    [server.routes :refer [preflight]]))

(timbre/refer-timbre)

(defn oracle-routes-fn [c]
  (let [api (:oracle-api c)]
    (defroutes oracle-routes
      (OPTIONS api request (preflight request))
      (POST api request 
        (let [oracle (:oracle c)
              data (spy (:body request))
              suggestions (spy (recommend oracle (:table data) (:columns data)))]
          (response suggestions)))

      (GET (str api "/properties") [q :as r] 
        (let [oracle (:oracle c)
              response (search-properties oracle q)]
          (json/write-str response)))

      (GET (str api "/classes") [q :as r] 
        (let [oracle (:oracle c)
              response (search-classes oracle q)]
          (json/write-str response))))))
