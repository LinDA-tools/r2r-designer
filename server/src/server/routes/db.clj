(ns server.routes.db
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [ring.util.codec :as codec]
    [server.core.db :refer :all]
    [clojure.data.json :refer [write-str]]
    [server.routes :refer [preflight]]))  

(timbre/refer-timbre)

(defn db-routes-fn [component]
  (let [api (:db-api component)
        db (:database component)]
    (defroutes db-routes
      (GET (str api "/tables") [] 
           (try 
             (write-str (get-tables db))
             (catch Exception _ {:status 500})))

      (GET (str api "/table-columns") [] 
           (try 
             (write-str (get-table-columns db))
             (catch Exception _ {:status 500})))

      ;; (GET (str api "/table") [name :as r] (str (seq (query-table db name))))

      (GET (str api "/column") [table name :as r] (str (seq (query-column db table name))))

      ;; (GET (str api "/columns") [table :as r] (str (seq (query-column-names-map db table))))

      ;; (GET (str api "/subjects") [table template predicate column :as r] 
      ;;   (let [template-decoded (codec/url-decode template)]
      ;;     (cond
      ;;       (and table template predicate column) (str (seq (predicate->column db table template-decoded predicate column)))
      ;;       (and table template) (str (seq (query-subject-template db table template-decoded)))
      ;;       :else {:status 400})))

      (OPTIONS (str api "/test") request (preflight request))
      (POST (str api "/test") [driver host name username password :as r]
        (let [spec {:driver driver
                    :host host
                    :name name 
                    :username username
                    :password password}
              result (test-db spec)]
          {:status 200 :body (str result)}))

      (OPTIONS (str api "/register") request (preflight request))
      (POST (str api "/register") [driver host name username password :as r]
        (let [db (:database component)
              new-spec {:host host
                        :driver driver
                        :name name 
                        :username username
                        :password password}]
          (register-db db new-spec)
          {:status 200})))))
