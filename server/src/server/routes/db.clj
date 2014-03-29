(ns server.routes.db
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    [server.core :refer :all]
    [server.system :as system]
    )
  )

(defroutes db-routes
  (GET "/tables" [] (str (seq (get-tables (:db (system/system))))))
  (GET "/table" [name :as r] (str (seq (query-table (:db (system/system)) name))))
  (GET "/columns" [table :as r] (str (seq (query-column-names-map (:db (system/system)) table))))
  (GET "/subjects" [table template predicate column :as r] 
    (cond
      (and table template predicate column) (str (seq (predicate->column (:db (system/system)) table template predicate column)))
      (and table template) (str (seq (query-subject-template (:db (system/system)) table template)))
      :else {:status 400}
      )
    )
  )
