(ns server.routes.app
  (:require
    [clojure.stacktrace :as st]
    [taoensso.timbre :as timbre]
    [ring.middleware.cors :refer :all]
    [ring.middleware.params :refer :all]
    [ring.middleware.multipart-params :refer :all]
    [ring.middleware.json :refer :all]
    [ring.middleware.file-info :refer :all]
    [compojure.core :refer :all]
    [compojure.handler :as handler]
    [compojure.route :as route]
    [server.routes.db :refer [db-routes-fn]]
    [server.routes.csv :refer [csv-routes-fn]]
    [server.routes.oracle :refer [oracle-routes-fn]]
    [server.routes.transform :refer [transform-routes-fn]]
    ))

(timbre/refer-timbre)

(defroutes app-routes
  (route/resources "/" {:root "."})
  (route/not-found "Not Found!"))

(defn allow-origin [handler]
  (fn [request]
    (let [response (handler request)
          headers (:headers response)]
      (assoc response :headers (assoc headers "Access-Control-Allow-Origin" "*")))))

(defn allow-content-type [handler]
  (fn [request]
    (let [response (handler request)
          headers (:headers response)]
      (assoc response :headers (assoc headers "Access-Control-Allow-Content-Type" "*")))))

(defn wrap-dir-index [handler]
  (fn [req]
    (handler
     (update-in req [:uri]
                #(if (= "/" %) "/index.html" %)))))

(defn monitor [handler]
  (fn [{:keys [request-method uri query-string] :as request}]
    (let [response (handler request)]
      (debug request)
      (info request-method uri query-string)
      (let [{:keys [status body]} response]
        (info status body)
        (debug response)
        response))))

(defn wrap-exception [f]
  (fn [request]
    (try (f request)
      (catch Exception e
        (let [stacktrace (with-out-str (st/print-stack-trace e))]
          {:status 500
           :body stacktrace})))))

(defn app-fn [component]
  (-> (routes (db-routes-fn component)
              (csv-routes-fn component)
              (oracle-routes-fn component) 
              (transform-routes-fn component) 
              app-routes)
      wrap-params
      wrap-multipart-params
      (wrap-json-body {:keywords? true})
      (wrap-json-response {:pretty true})
      ;; (wrap-cors :access-control-allow-origin [#"http://127.0.0.1:9000" #"http://localhost:9000"] 
      ;;            :access-control-allow-methods [:get :put :post :delete :options])
      wrap-exception
      allow-content-type
      allow-origin
      wrap-dir-index
      wrap-file-info
      monitor
      ))
