(ns server.handler
  (:require 
    [ring.middleware.cors :as cors]
    [compojure.core :refer :all]
    [compojure.handler :as handler]
    [compojure.route :as route]
    [server.routes.db :refer :all]
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
  (-> (routes db-routes app-routes)
    handler/site
    (cors/wrap-cors
      :access-control-allow-origin #"http://localhost:9000") 
    ;; wrap-base-url
    )
  )
