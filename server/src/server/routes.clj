(ns server.routes
  (:require 
    [ring.util.response :refer [response]]))

(defn preflight [request]
  (assoc
    (response "CORS enabled")
    :headers {"Access-Control-Allow-Origin" "*" 
              "Access-Control-Allow-Methods" "PUT, DELETE, POST, GET, OPTIONS, XMODIFY" 
              "Access-Control-Max-Age" "2520"
              "Access-Control-Allow-Credentials" "true"
              "Access-Control-Request-Headers" "x-requested-with, content-type, origin, accept"
              "Access-Control-Allow-Content-Type" "*" 
              "Access-Control-Allow-Headers" "x-requested-with, content-type, origin, accept"}))
