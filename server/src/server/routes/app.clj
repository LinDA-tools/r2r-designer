(ns server.routes.app
  (:require
    [taoensso.timbre :as timbre]
    [ring.middleware.cors :refer :all]
    [ring.middleware.params :refer :all]
    [ring.middleware.json :refer :all]
    [compojure.core :refer :all]
    [compojure.handler :as handler]
    [compojure.route :as route]
    [server.routes.db :refer [db-routes-fn]]
    [server.routes.oracle :refer [oracle-routes-fn]]))

(timbre/refer-timbre)

(defroutes app-routes
  (route/resources "/")
  (route/not-found "Not Found!"))

(defn wrap-request-logging [handler]
  (fn [{:keys [request-method uri query-string] :as request}]
    (let [response (handler request)]
      (debug request-method uri query-string)
        response)))

(defn wrap-response-logging [handler]
  (fn [request]
    (let [response (handler request)]
      (debug (:status response) (:body response)) 
      response)))

(defn app-fn [component]
  (-> (routes (db-routes-fn component) 
              (oracle-routes-fn component) 
              app-routes)
    wrap-request-logging
    wrap-response-logging
    (wrap-cors :access-control-allow-origin #"http://localhost:9000")
    (wrap-cors :access-control-allow-origin #"http://127.0.0.1:9000")
    wrap-params
    (wrap-json-body {:keywords? true})
    wrap-json-response))
