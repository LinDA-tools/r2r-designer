(ns server.routes.lov
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    [server.core.lov :as lov]
    ;; [server.system :as system]
    )
  )

(def api "/api/v1/lov")

(defroutes lov-routes
  (GET (str api "/property") [name :as r] 
    (str (seq (lov/filter-results (lov/search-property name))))
    )
  (GET (str api "/class") [name :as r] 
    (str (seq (lov/filter-results (lov/search-class name))))
    )
  )

