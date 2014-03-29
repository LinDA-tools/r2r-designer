(ns server.core
  (:require
    [clojure.java.io :as io]
    [clojure.java.jdbc :as jdbc]
    [clojure.string :as str]
    [clojure.tools.logging :refer [info debug error spy]]
    [server.system :as system]
    )
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

(defn get-tables [db]
  (debug db)
  (if db 
    (let [result (jdbc/query db "SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = 'public'")
          tables (map :table_name result)]
      (debug tables)
      tables 
      )
    )
  )

(defn query-column-names [db table]
  (debug db table)
  (if db 
    (let [result (jdbc/query db (str "SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '" table "'"))
          columns (map :column_name result)]
      (debug columns)
      columns 
      )
    )
  )

(defn query-column-names-map [db table]
  (debug db table)
  (if db 
    (let [columns (query-column-names db table)
          result (apply merge (for [i columns] {(keyword (str/lower-case i)) i}))]
      (debug result)
      result 
      )
    )
  )

(defn query-columns [db table columns]
  (debug db table columns)
  (if db 
    (let [columns-joined (str/join ", " (map #(str "\"" % "\"") columns))
          result (jdbc/query db (str "SELECT " columns-joined " FROM " table))]
      (debug result)
      result 
      )
    )
  )

(defn query-column [db table column]
  (debug db table column)
  (if db 
    (let [result (jdbc/query db (str "SELECT \"" column "\" FROM " table))
          values (map second (map first result))]
      (debug values)
      values 
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

(defn parse-template-str [template-str]
  (debug template-str)
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
  (debug template-str)
  (let [p #"\{[^\}]*\}"
        matches (re-seq p template-str)
        columns (for [i matches] (subs i 1 (- (count i) 1)))]
    (debug columns)
    columns
    )
  )

(defn match-template [template row]
  (debug template row)
  (str/join (for [i template] (if (keyword? i) (i row) i)))
  )

(defn query-subject-template [db table template-str]
  (debug db table template-str)
  (let [template (parse-template-str template-str)
        columns (parse-columns template-str)
        data (query-columns db table columns)
        result (take 20 (for [row data] (match-template template row)))]
    (debug result)
    result
    )
  )

(defn predicate->column [db table template-str predicate column]
  (debug db table template-str predicate column)
  (let [template (parse-template-str template-str)
        columns (parse-columns template-str)
        data (query-columns db table (conj columns column))
        column-kw (column->kw column)
        result (take 20 (for [row data] [(match-template template row) predicate (column-kw row)]))]
    (debug result)
    result 
    )
  )
