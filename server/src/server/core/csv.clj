(ns server.core.csv
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.java.io :as io]
    [clojure.data.csv :as csv]
    [clojure.string :as str])
  )

(timbre/refer-timbre)

(defn set-file [c file]
  (reset! (:csv-file c) file))

(defn transpose [m] (apply mapv vector m))

(defn get-data [c]
  (let [file @(:csv-file c)]
    (if file
      (with-open [r (io/reader file)] (doall (take 10 (csv/read-csv r))))
      [])))
