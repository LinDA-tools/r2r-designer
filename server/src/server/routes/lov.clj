(ns server.routes.lov
  (:require 
    [compojure.core :refer :all]
    [clojure.tools.logging :refer [info debug error]]
    [server.core.lov :refer :all]
    )
  )

(defn lov-routes-fn [component]
  (let [api (:lov-api component)
        lov (:lov component)]
    (defroutes lov-routes
      (GET (str api "/property") [name :as r] 
        (str (seq (filter-results (search-property lov name))))
        )
      (GET (str api "/class") [name :as r] 
        (str (seq (filter-results (search-class lov name))))
        )
      )
    )
  )

