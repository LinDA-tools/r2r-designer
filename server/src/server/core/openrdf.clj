(ns server.core.openrdf
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre])
  (:import
    org.openrdf.rio.RDFFormat
    org.openrdf.model.Resource))

(timbre/refer-timbre)

(defn upload! [c f]
  (let [repo @(:server c)
        uri (:base-uri c)]
    (with-open [conn (.getConnection repo)]
      (.add conn f uri RDFFormat/NTRIPLES (into-array Resource [])))
    (str (:host c) "/" (:repo c))))
