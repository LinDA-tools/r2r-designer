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
  (route/resources "/" {:root "."})
  (route/not-found "Not Found!"))

(defn allow-content-type [handler]
  (fn [request]
    (let [response (handler request)
          headers (:headers response)]
      (assoc response :headers (assoc headers "Access-Control-Allow-Content-Type" "application/json")))))

(defn wrap-dir-index [handler]
  (fn [req]
    (handler
     (update-in req [:uri]
                #(if (= "/" %) "/index.html" %)))))

(defn monitor [handler]
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
      wrap-params
      (wrap-json-body {:keywords? true})
      (wrap-json-response {:pretty true})
      ;; (wrap-cors :access-control-allow-origin [#"http://localhost:9000" #"http://127.0.0.1:9000"]
      ;;            :access-control-allow-methods [:get :put :post :delete :options])
      wrap-dir-index
      monitor
      ))
