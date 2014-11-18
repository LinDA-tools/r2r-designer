(ns server.core.sparqlify
  (:require
    [clojure.java.shell :as sh]
    [clojure.java.io :as io]
    [taoensso.timbre :as timbre])
  (:import java.io.File))

(timbre/refer-timbre)

(defn sparqlify-dump [c mapping-file]
  (let [db-spec @(:spec (:database c))
        args ["./bin/sparqlify.sh" "-D" 
              "-m" mapping-file 
              "-h" (:host db-spec) 
              "-d" (:name db-spec) 
              "-U" (:username db-spec) 
              (if (seq (:password db-spec)) "-W") (if (:password db-spec) (:password db-spec))]
        out (:out (apply sh/sh (remove nil? args)))
        f (File/createTempFile "dump" ".n3")]
    (spit f out)
    f))
