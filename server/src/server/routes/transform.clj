(ns server.routes.transform
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

(defn transform-routes-fn [c]
  (let [api (:transform-api c)]
    (defroutes transform-routes
      (OPTIONS api request (preflight request))
      (POST api transform 
        (let [sparqlify (:sparqlify c)
              ]
          (response suggestions)))
      )))
