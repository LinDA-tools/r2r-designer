(ns server.core
  (:require
    [clojure.java.io :as io]
    [clojure.java.jdbc :as jdbc]
    [clojure.string :as str]
    [clojure.tools.logging :refer [info debug error]]
    [server.system :as system]
    )
  )

(defn sql-script [fname] (slurp (io/resource fname)))
(defn sql-commands [f] (str/split f #";"))

(defn drop-bytes [m]
  (let [byte-class (class (byte-array 0))
        keys-to-drop (filter #(instance? byte-class (get m %)) (keys m))]
    (apply dissoc m keys-to-drop)
    )
  )

(defn get-tables [db]
  (debug db)
  (if db 
    (let [result (jdbc/query db "SELECT * FROM INFORMATION_SCHEMA.SYSTEM_TABLES")
          tables (map :table_name result)
          filtered (filter #(not (.startsWith % "SYSTEM_")) tables)]
      (debug filtered)
      filtered 
      )
    )
  )

(defn query-columns [db table]
  (debug db table)
  (if db 
    (let [result (jdbc/query db (str "SELECT * FROM INFORMATION_SCHEMA.SYSTEM_COLUMNS WHERE table_name = '" table "'"))
          columns (map :column_name result)]
      (debug columns)
      columns 
      )
    )
  )

(defn query-table [db table]
  (debug db table)
  (if db 
    (let [result (take 20 (jdbc/query db (str "SELECT * FROM " table)))
          filtered (map drop-bytes result)]
      (debug filtered)
      filtered 
      )
    )
  )
