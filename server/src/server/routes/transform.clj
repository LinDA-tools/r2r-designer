(ns server.routes.transform
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [clojure.set :refer :all]
    [ring.util.codec :as codec]
    [ring.util.response :refer [response file-response]]
    [clojure.java.io :as io]
    [clojure.data.json :as json]
    [server.core.db :as db]
    [server.core.sparqlify :refer :all]
    [server.routes :refer [preflight]])
  (:import java.io.File)) 


(timbre/refer-timbre)

(defn transform-routes-fn [c]
  (let [api (:transform-api c)]
    (defroutes transform-routes

      (OPTIONS (str api "/dump") request (preflight request))
      (POST (str api "/dump") request
        (let [sparqlify (:sparqlify c)
              file-store (:file-store c) 
              mapping (spy (:mapping (:body request)))
              f (spy (mapping-to-file mapping))
              dump-file (spy (sparqlify-dump sparqlify (str f)))
              -hash (spy (hash dump-file))]
          (swap! file-store (fn [x] (assoc x -hash dump-file))) 
          {:status 200 :body (str (:transformApi c) "/file/" -hash ".n3")}))

      (OPTIONS (str api "/publish/:to") request (preflight request))
      (POST (str api "/publish/:to") [to :as r]
        (let [sparqlify (:sparqlify c)
              file-store (:file-store c) 
              mapping (:mapping (:body r))
              f (mapping-to-file mapping)
              endpoint (start-sparql-endpoint! sparqlify (str f))]
          (info to)
          {:status 200 :body endpoint}))

      ;; TODO: possible access to arbitrary files on the system through known filenames?
      (GET (str api "/file/:id") [id]
        (let [-hash (second (re-find #"(.*)\.n3" id))
              sparqlify (:sparqlify c)
              file-store (:file-store c)
              f (get @file-store (Integer. -hash))]
          (if f (file-response (str f)))))
      )))
