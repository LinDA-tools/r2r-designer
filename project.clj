(defproject r2r-server "0.1.0-SNAPSHOT"
  :description "r2r-designer server component"
  :url "http://linda-project.eu"
  :license {:name "MIT"
            :url "http://choosealicense.com/"}
  :dependencies [[org.clojure/clojure "1.5.1"]]
  :profiles {:dev {:dependencies [[org.clojure/tools.namespace "0.2.4"]]
                   :source-paths ["server/dev" "server/src"]}})
