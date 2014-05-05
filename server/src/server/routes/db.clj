(ns server.routes.db
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    [ring.util.codec :as codec]
    [server.core.db :refer :all]
    )
  )

(defn db-routes-fn [component]
  (let [api (:db-api component)
        spec (:spec (:database component))]
    (defroutes db-routes
      (GET (str api "/tables") [] (str (seq (get-tables spec))))
      (GET (str api "/table") [name :as r] (str (seq (query-table spec name))))
      (GET (str api "/columns") [table :as r] (str (seq (query-column-names-map spec table))))
      (GET (str api "/subjects") [table template predicate column :as r] 
        (let [template-decoded (codec/url-decode template)]
          (cond
            (and table template predicate column) (str (seq (predicate->column spec table template-decoded predicate column)))
            (and table template) (str (seq (query-subject-template spec table template-decoded)))
            :else {:status 400}
            )
          )
        )
      )
    )
  )
