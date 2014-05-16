(ns server.routes.app
  (:require
    [taoensso.timbre :as timbre]
    [ring.middleware.cors :as cors]
    [compojure.core :refer :all]
    [compojure.handler :as handler]
    [compojure.route :as route]
    [server.routes.db :refer [db-routes-fn]]
    [server.routes.lov :refer [lov-routes-fn]]
    [server.routes.recommender :refer [recommender-routes-fn]]
    )
  )
(timbre/refer-timbre)

(defroutes app-routes
  (route/resources "/")
  (route/not-found "Not Found!")
  )

(defn app-fn [component]
  (-> (routes (db-routes-fn component) 
              (lov-routes-fn component) 
              (recommender-routes-fn component) 
              app-routes)
    handler/site
    (cors/wrap-cors :access-control-allow-origin #"http://localhost:9000") 
    (cors/wrap-cors :access-control-allow-origin #"http://127.0.0.1:9000") 
    )
  )

