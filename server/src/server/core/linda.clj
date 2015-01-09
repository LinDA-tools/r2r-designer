(ns server.core.linda
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clj-http.client :as http]
    [clojure.data.json :as json]))

(timbre/refer-timbre)

(defn create-repo! [c title -format content]
  (let [host (:host c)
        api (str host "/datasource/create/")
        response (http/post api {:form-params {:title title :format -format :content content}})]
    response))

(defn read-repo [c title]
  (let [host (:host c)
        api (str host "/datasource/" title "/")
        response (http/get api)]
    response))

(defn read-repos [c]
  (let [host (:host c)
        api (str host "/datasources/")
        response (http/get api)]
    response))

(defn repo-exists? [c title]
  (let [repos (json/read-json (:body (read-repos c)))]
    (seq (filter #(= title (:title %)) repos))))

(defn update-repo! [c title -format content]
  (let [host (:host c)
        api (str host "/datasource/" title "/replace/")
        response (http/post api {:form-params {:format -format :content content}})]
    response))

(defn delete-repo! [c title]
  (let [host (:host c)
        api (str host "/datasource/" title "/delete/")
        response (http/post api)]
    response))

(defn upload! [c title f]
  (if (repo-exists? c title)
    (update-repo! c title "text/rdf+n3" (slurp f))
    (create-repo! c title "text/rdf+n3" (slurp f)))
  (str (:host c) "/datasources/" title "/"))
