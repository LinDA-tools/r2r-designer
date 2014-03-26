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
(defn sql-commands [f] 
  (let [lines (str/split f #"\n")
        no-comments (filter #(not (re-matches #"--.*" %)) lines)
        no-comments-joined
            (->> no-comments
              (filter seq)
              (str/join))]
    (-> no-comments-joined 
      (str/split #";")
      )
    )
  )

(defn drop-bytes [m]
  (let [byte-class (class (byte-array 0))
        keys-to-drop (filter #(instance? byte-class (get m %)) (keys m))]
    (apply dissoc m keys-to-drop)
    )
  )

(defn get-tables [db]
  (debug db)
  (if db 
    (let [result (jdbc/query db "SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = 'public'")
          tables (map str/upper-case (map :table_name result))]
      (debug tables)
      tables 
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
