(ns server.core.db
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [clojure.java.io :as io]
    [clojure.java.jdbc :as jdbc]
    [clojure.string :as str])
  (:import
    [java.sql DriverManager]
    [com.zaxxer.hikari HikariDataSource HikariConfig]))

(timbre/refer-timbre)

(defn new-datasource [c]
  (let [max-pool (:max-pool c)
        spec @(:spec c)
        ds (HikariDataSource.)]
    (doto ds 
      (.setMaximumPoolSize max-pool)
      (.setConnectionTestQuery "SELECT 1")
      (.setDataSourceClassName (:driver spec))
      (.addDataSourceProperty "serverName" (:host spec))
      (.addDataSourceProperty "databaseName" (:name spec))
      (.addDataSourceProperty "user" (:username spec))
      (.addDataSourceProperty "password" (:password spec)))
    ds))

(defn test-db [spec]
  (let [host (:host spec)
        name (:name spec)
        user (:username spec)
        pass (:password spec)
        connection-str (str "jdbc:postgresql://" host "/" name)]
    (try 
      (let [conn (DriverManager/getConnection connection-str user pass)]
        (.close conn)
        true)
      (catch Exception e false))))

(defn register-db [db new-spec]
  (info "registering new data source")
  (debug new-spec)
  (if db 
    (c/stop db))
  (reset! (:spec db) new-spec)
  (c/start db))

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
      (str/split #";"))))

(defn drop-bytes [m]
  (let [byte-class (class (byte-array 0))
        keys-to-drop (filter #(instance? byte-class (get m %)) (keys m))]
    (apply dissoc m keys-to-drop)))

(defn get-tables [c]
  (let [ds {:datasource @(:datasource c)}
        result (jdbc/query ds "SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = 'public'")
        tables (map :table_name result)]
    (debug tables)
    tables))

(defn get-columns [c table]
  (let [ds {:datasource @(:datasource c)}
        result (jdbc/query ds (str "SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '" table "'"))
        columns (map :column_name result)]
    (debug columns)
    columns))

(defn get-table-columns [c]
  (let [ds {:datasource @(:datasource c)}
        tables (get-tables c)
        table-columns (apply merge (for [table tables] {table (get-columns c table)}))]
    table-columns))

(defn query-column-names-map [c table]
  (let [ds {:datasource @(:datasource c)}
        columns (get-columns c table)
        result (apply merge (for [i columns] {(keyword (str/lower-case i)) i}))]
    (debug result)
    result))

(defn query-columns [c table columns]
  (let [ds {:datasource @(:datasource c)}
        columns-joined (str/join ", " (map #(str "\"" % "\"") columns))
        result (jdbc/query ds (str "SELECT " columns-joined " FROM " table))]
    (debug result)
    result))

(defn query-column [c table column]
  (let [ds {:datasource @(:datasource c)}
        result (jdbc/query ds (str "SELECT \"" column "\" FROM " table))
        values (map second (map first result))]
    (debug values)
    values))

(defn query-table [c table]
  (let [ds {:datasource @(:datasource c)}
        result (take 20 (jdbc/query ds (str "SELECT * FROM " table)))
        filtered (map drop-bytes result)]
    (debug filtered)
    filtered))

(defn parse-template-str [template-str]
  (let [p #"\{[^\}]*\}"
        leftovers (str/split template-str p)
        matches (re-seq p template-str)
        matched-kws (map column->kw (map #(subs % 1 (- (count %) 1)) matches))
        template (interleave leftovers matched-kws)
        ]
    (debug template)
    template))

(defn parse-columns [template-str]
  (let [p #"\{[^\}]*\}"
        matches (re-seq p template-str)
        columns (for [i matches] (subs i 1 (- (count i) 1)))]
    (debug columns)
    columns))

(defn match-template [template row]
  (str/join (for [i template] (if (keyword? i) (i row) i))))

(defn query-subject-template [c table template-str]
  (let [ds {:datasource @(:datasource c)}
        template (parse-template-str template-str)
        columns (parse-columns template-str)
        data (query-columns c table columns)
        result (take 20 (for [row data] (match-template template row)))]
    (debug result)
    result))

(defn property->column [c table template-str property column]
  (let [ds {:datasource @(:datasource c)}
        template (parse-template-str template-str)
        columns (parse-columns template-str)
        data (query-columns c table (conj columns column))
        column-kw (column->kw column)
        result (take 20 (for [row data] [(match-template template row) property (column-kw row)]))]
    (debug result)
    result))
