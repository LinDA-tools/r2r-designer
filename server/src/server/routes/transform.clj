(ns server.routes.transform
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [clojure.set :refer :all]
    [ring.util.codec :as codec]
    [ring.util.response :refer [response file-response]]
    [clojure.data.json :as json]
    [server.core.db :as db]
    [server.core.sparqlify :refer :all]
    [server.routes :refer [preflight]]))


(timbre/refer-timbre)

(defn transform-routes-fn [c]
  (let [api (:transform-api c)]
    (defroutes transform-routes
      (OPTIONS api request (preflight request))
      (POST api request 
        (let [sparqlify (:sparqlify c)
              mapping-file (-> request :multipart-params (get "file") :tempfile)
              dump-file (if mapping-file (sparqlify-dump sparqlify (str mapping-file)))]
          (info mapping-file)
          (info dump-file)
          (if dump-file 
            (file-response (str dump-file))
            {:status 400 :body "mapping file is missing"}))
        ))))
