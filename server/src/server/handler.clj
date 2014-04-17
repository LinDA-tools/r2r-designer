(ns server.handler
  (:require 
    [ring.middleware.cors :as cors]
    [compojure.core :refer :all]
    [compojure.handler :as handler]
    [compojure.route :as route]
    [server.routes.db :as db]
    [server.routes.lov :as lov]
    )
  )

(defn init []
  (println "server is starting"))

(defn destroy []
  (println "server is shutting down"))

(defroutes app-routes
  (route/resources "/")
  (route/not-found "Not Found!")
  )

(def app
  (-> (routes 
        db/db-routes
        lov/lov-routes
        app-routes)
    handler/site
    (cors/wrap-cors :access-control-allow-origin #"http://localhost:9000") 
    (cors/wrap-cors :access-control-allow-origin #"http://127.0.0.1:9000") 
    ;; wrap-base-url
    )
  )
