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
    [server.core.linda :refer :all]
    [server.routes :refer [preflight]])
  (:import java.io.File)) 


(timbre/refer-timbre)

(defn transform-routes-fn [c]
  (let [api (:transform-api c)]
    (defroutes transform-routes

      (OPTIONS (str api "/dump-db") r (preflight r))
      (POST (str api "/dump-db") r
        (let [sparqlify (:sparqlify c)
              file-store (:file-store c) 
              mapping (spy (:mapping (:body r)))
              f (spy (mapping-to-file mapping))
              dump-file (spy (sparqlify-dump sparqlify (str f)))
              -hash (spy (hash dump-file))]
          (swap! file-store (fn [x] (assoc x -hash dump-file))) 
          {:status 200 :body (str (:transformApi c) "/file/" -hash ".nt")}))

      (OPTIONS (str api "/dump-csv") r (preflight r))
      (POST (str api "/dump-csv") r
        (let [sparqlify (:sparqlify c)
              file-store (:file-store c) 
              mapping (:mapping (:body r))
              f (spy (mapping-to-file mapping))
              dump-file (spy (sparqlify-csv sparqlify (str f)))
              -hash (hash dump-file)]
          (swap! file-store (fn [x] (assoc x -hash dump-file))) 
          {:status 200 :body (str (:transformApi c) "/file/" -hash ".nt")}))

      (OPTIONS (str api "/publish/linda") r (preflight r))
      (POST (str api "/publish/linda") r 
        (let [sparqlify (:sparqlify c)
              linda (:linda c)
              file-store (:file-store c) 
              datasource-name (:datasource (spy (:body r)))
              mapping (:mapping (:body r))
              f (mapping-to-file mapping)
              dump-file (sparqlify-csv sparqlify (str f))
              endpoint (upload! linda datasource-name dump-file)]
          {:status 200 :body endpoint}))
      
      (OPTIONS (str api "/publish/sparqlify") r (preflight r))
      (POST (str api "/publish/sparqlify") r 
        (let [sparqlify (:sparqlify c)
              mapping (:mapping (:body r))
              f (mapping-to-file mapping)
              endpoint (start-sparql-endpoint! sparqlify (str f))]
          {:status 200 :body endpoint}))

      ;; TODO: possible access to arbitrary files on the system through known filenames?
      (GET (str api "/file/:id") [id]
        (let [-hash (second (re-find #"(.*)\.nt" id))
              sparqlify (:sparqlify c)
              file-store (:file-store c)
              f (get @file-store (Integer. -hash))]
          (if f (file-response (str f)))))
      )))
