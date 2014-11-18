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
      (OPTIONS api request (preflight request))
      (POST api request
        (let [sparqlify (:sparqlify c)
              file-store (:file-store c) 
              mapping (:mapping (:body request))
              mapping-file (if mapping (File/createTempFile "mapping" ".sml"))]
          (when mapping-file 
            (spit mapping-file mapping)
            (let [dump-file (sparqlify-dump sparqlify (str mapping-file))]
              (if dump-file
                (let [id (hash (str dump-file))]
                  (swap! file-store (fn [x] (assoc x (hash (str dump-file)) dump-file))) 
                  {:status 200 :body (str (:transformApi c) "/file/" id)}) 
                {:status 400 :body "mapping file is missing"})))))

      ;; (OPTIONS (str api "/mapping") request (preflight request))
      ;; (POST (str api "/mapping") request
      ;;   (let [file-store (:file-store c) 
      ;;         mapping (:mapping (:body request))
      ;;         mapping-file (if mapping (File/createTempFile "mapping" ".sml"))]
      ;;     (when mapping-file 
      ;;       (spit mapping-file mapping)
      ;;       (let [id (hash (str mapping-file))]
      ;;         (swap! file-store (fn [x] (assoc x (hash (str mapping-file)) mapping-file))) 
      ;;         {:status 200 :body (str (:transformApi c) "/file/" id)}))))

      ;; TODO: possible access to arbitrary files on the system through known filename
      (GET (str api "/file/:id") [id]
        (let [sparqlify (:sparqlify c)
              file-store (:file-store c)]
          (let [f (get @file-store (Integer. id))]
            (println id)
            (println file-store)
            (println f)
            (if f (file-response (str f))))))
      )))
