(ns server.core.csv
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.java.io :as io]
    [clojure.data.csv :as csv]
    [clojure.string :as str])
  )

(timbre/refer-timbre)

(defn separator [file]
  (let [first-line (re-find #".*[\n\r]" (slurp file))
        tabs (count (filter #(= \tab %) first-line))
        commata (count (filter #(= \, %) first-line))]
    (if (> tabs commata)
      \tab
      \,)))

(defn set-file [c file]
  (reset! (:csv-file c) file)
  (reset! (:separator c) (separator file)))

(defn get-data [c]
  (let [file @(:csv-file c)
        separator @(:separator c)]
    (if file
      (with-open [r (io/reader file)] (doall (take 10 (csv/read-csv r :separator separator))))
      [])))
