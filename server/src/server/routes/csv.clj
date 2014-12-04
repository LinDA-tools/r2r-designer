(ns server.routes.csv
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [ring.util.codec :as codec]
    [server.core.csv :refer :all]
    [clojure.data.json :refer [write-str]]
    [server.routes :refer [preflight]]))  

(timbre/refer-timbre)

(defn csv-routes-fn [component]
  (let [api (:csv-api component)
        ds (:datasource component)]
    (defroutes csv-routes

      (GET (str api "/data") [] 
           (try 
             (write-str (get-data ds))
             (catch Exception _ {:status 500})))

      (OPTIONS (str api "/upload") request (preflight request))
      (POST (str api "/upload") request
        (let [file (-> request :multipart-params (get "file") :tempfile)]
          (try 
            (do
              (set-file ds file)
              (info @(:csv-file ds))
              {:status 200 :body "uploaded"}  
              ) 
            (catch Exception _ {:status 400 :body "error"})))))))
