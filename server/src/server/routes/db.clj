(ns server.routes.db
  (:require 
    [compojure.core :refer :all]
    [taoensso.timbre :as timbre]
    [ring.util.codec :as codec]
    [server.core.db :refer :all]
    )
  )
(timbre/refer-timbre)

(defn db-routes-fn [component]
  (let [api (:db-api component)
        db (:database component)]
    (defroutes db-routes
      (GET (str api "/tables") [] (str (seq (get-tables db))))
      (GET (str api "/table") [name :as r] (str (seq (query-table db name))))
      (GET (str api "/columns") [table :as r] (str (seq (query-column-names-map db table))))
      (GET (str api "/subjects") [table template predicate column :as r] 
        (let [template-decoded (codec/url-decode template)]
          (cond
            (and table template predicate column) (str (seq (predicate->column db table template-decoded predicate column)))
            (and table template) (str (seq (query-subject-template db table template-decoded)))
            :else {:status 400}
            )
          )
        )
      (POST (str api "/config/register") [subname subprotocol username password :as r]
        (let [db (:database component)
              new-spec {:subname subname 
                        :subprotocol subprotocol 
                        :username username
                        :password password}]
          (register-db db new-spec)
          "success"
          )
        )
      )
    )
  )
