(ns server.core.db
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.java.io :as io]
    [clojure.java.jdbc :as jdbc]
    [clojure.string :as str]
    )
  (:import
    [java.sql DriverManager]
    [com.jolbox.bonecp BoneCPDataSource])
  )

(timbre/refer-timbre)

(defn test-db [spec]
  (let [sp (:subprotocol spec)
        host (:host spec)
        sn (:subname spec)
        user (:username spec)
        pass (:password spec)
        connection-str (str "jdbc:" sp "://" host "/" sn)]
    (try 
      (do
        (DriverManager/getConnection connection-str user pass)
        true
        )
      (catch Exception e false)
      )
    )
  )

(defn new-pool [c]
  (let [min-pool (:min-pool c)
        max-pool (:max-pool c)
        partitions (:partitions c)
        spec @(:spec c)
        cpds (doto (BoneCPDataSource.)
               (.setJdbcUrl (str "jdbc:" (:subprotocol spec) ":" (:subname spec)))
               (.setUsername (:username spec))
               (.setPassword (:password spec))
               (.setMinConnectionsPerPartition (inc (int (/ min-pool partitions))))
               (.setMaxConnectionsPerPartition (inc (int (/ max-pool partitions))))
               (.setPartitionCount partitions)
               (.setStatisticsEnabled true)
               ;; test connections every 25 mins (default is 240):
               (.setIdleConnectionTestPeriodInMinutes 25)
               ;; allow connections to be idle for 3 hours (default is 60 minutes):
               (.setIdleMaxAgeInMinutes (* 3 60))
               ;; consult the BoneCP documentation for your database:
               (.setConnectionTestStatement "/* ping *\\/ SELECT 1"))] 
    {:datasource cpds})
  )

(defn register-db [db new-spec]
  (info "registering new data source")
  (debug new-spec)
  (if db 
    (c/stop db))
  (reset! (:spec db) new-spec)
  (c/start db) 
  )

(defn column->kw [column] (keyword (str/lower-case column)))

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

(defn get-tables [c]
  (let [pool @(:pool c)
        result (jdbc/query pool "SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = 'public'")
        tables (map :table_name result)]
    (debug tables)
    tables 
    )
  )

(defn get-columns [c table]
  (let [pool @(:pool c)
        result (jdbc/query pool (str "SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '" table "'"))
        columns (map :column_name result)]
    (debug columns)
    columns 
    )
  )

(defn get-table-columns [c]
  (let [pool @(:pool c)
        tables (get-tables c)
        table-columns (apply merge (for [table tables] {table (get-columns c table)}))]
    table-columns 
    ) 
  )

(defn query-column-names-map [c table]
  (let [pool @(:pool c)
        columns (get-columns c table)
        result (apply merge (for [i columns] {(keyword (str/lower-case i)) i}))]
    (debug result)
    result))

(defn query-columns [c table columns]
  (let [pool @(:pool c)
        columns-joined (str/join ", " (map #(str "\"" % "\"") columns))
        result (jdbc/query pool (str "SELECT " columns-joined " FROM " table))]
    (debug result)
    result 
    )
  )

(defn query-column [c table column]
  (let [pool @(:pool c)
        result (jdbc/query pool (str "SELECT \"" column "\" FROM " table))
        values (map second (map first result))]
    (debug values)
    values 
    )
  )

(defn query-table [c table]
  (let [pool @(:pool c)
        result (take 20 (jdbc/query pool (str "SELECT * FROM " table)))
        filtered (map drop-bytes result)]
    (debug filtered)
    filtered 
    )
  )

(defn parse-template-str [template-str]
  (let [p #"\{[^\}]*\}"
        leftovers (str/split template-str p)
        matches (re-seq p template-str)
        matched-kws (map column->kw (map #(subs % 1 (- (count %) 1)) matches))
        template (interleave leftovers matched-kws)
        ]
    (debug template)
    template
    )
  )

(defn parse-columns [template-str]
  (let [p #"\{[^\}]*\}"
        matches (re-seq p template-str)
        columns (for [i matches] (subs i 1 (- (count i) 1)))]
    (debug columns)
    columns
    )
  )

(defn match-template [template row]
  (str/join (for [i template] (if (keyword? i) (i row) i)))
  )

(defn query-subject-template [c table template-str]
  (let [pool @(:pool c)
        template (parse-template-str template-str)
        columns (parse-columns template-str)
        data (query-columns c table columns)
        result (take 20 (for [row data] (match-template template row)))]
    (debug result)
    result
    )
  )

(defn property->column [c table template-str property column]
  (let [pool @(:pool c)
        template (parse-template-str template-str)
        columns (parse-columns template-str)
        data (query-columns c table (conj columns column))
        column-kw (column->kw column)
        result (take 20 (for [row data] [(match-template template row) property (column-kw row)]))]
    (debug result)
    result 
    )
  )
