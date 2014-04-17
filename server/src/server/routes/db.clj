(ns server.routes.db
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    [server.core.db :as db]
    [server.system :as system]
    )
  )

(def api "/api/v1/db")

(defroutes db-routes
  (GET (str api "/tables") [] 
    (str (seq (db/get-tables (:db (system/system))))))
  (GET (str api "/table") [name :as r] 
    (str (seq (db/query-table (:db (system/system)) name))))
  (GET (str api "/columns") [table :as r] 
    (str (seq (db/query-column-names-map (:db (system/system)) table))))
  (GET (str api "/subjects") [table template predicate column :as r] 
    (cond
      (and table template predicate column) (str (seq (db/predicate->column (:db (system/system)) table template predicate column)))
      (and table template) (str (seq (db/query-subject-template (:db (system/system)) table template)))
      :else {:status 400}
      )
    )
  )
