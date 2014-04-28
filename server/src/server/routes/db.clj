(ns server.routes.db
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    )
  )

(defn db-routes-fn [component]
  (let [db (:db component)]
    (defroutes db-routes
      (GET "/tables" [] (str (seq (get-tables db))))
      (GET "/table" [name :as r] (str (seq (query-table db name))))
      (GET "/columns" [table :as r] (str (seq (query-column-names-map db table))))
      (GET "/subjects" [table template predicate column :as r] 
        (cond
          (and table template predicate column) (str (seq (predicate->column db table template predicate column)))
          (and table template) (str (seq (query-subject-template db table template)))
          :else {:status 400}
          )
        )
      )
    )
  )
