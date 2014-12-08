(defproject r2r-designer.server "0.1.0-SNAPSHOT"
  :description "server component for the r2r-designer"
  :url "http://linda-project.eu"
  :license { :name "MIT"
             :url "http://opensource.org/licenses/MIT" }
  :repositories [["aksw-internal" "http://maven.aksw.org/repository/internal/"]]
  :dependencies [
    [org.clojure/clojure "1.6.0"]
    [org.clojure/java.jdbc "0.3.3"]
    [org.clojure/data.json "0.2.4"]
    [com.stuartsierra/component "0.2.1"]
    [compojure "1.1.8"]
    [ring-server "0.3.1"]
    [ring-cors "0.1.4"]
    [ring/ring-json "0.3.1"]
    [clj-http "0.9.2"]
    [edu.ucdenver.ccp/kr-sesame-core "1.4.17"]
    [com.taoensso/timbre "3.2.1"]
    [org.postgresql/postgresql "9.3-1102-jdbc41"]
    [com.zaxxer/HikariCP-java6 "2.2.5"]
    [org.aksw.sparqlify/sparqlify-core "0.6.12" :exclusions [[postgresql/postgresql]]]
    [org.clojure/data.csv "0.1.2"]]
  :plugins [[lein-ring "0.8.13"]]
  :ring {:init server.system/init
         :destroy server.system/destroy
         :handler server.system/app}
  :source-paths ["server/src"]
  :test-paths ["server/test"]
  :resource-paths ["server/resource" "dist"]
  :profiles {
    :dev {
      :dependencies [
        [org.clojure/tools.namespace "0.2.5"]
        [org.clojure/java.classpath "0.2.2"]
        [ring-mock "0.1.5"]
        [ring/ring-devel "1.3.0"]
        ]
      :source-paths ["server/dev"]
      :resource-paths [".tmp" "app"]
      }
    :uberwar {
      :aot :all
      :main server.system
      :resource-paths ["dist"]
    }
    :uberjar {
      :aot :all
      :main server.system
      :resource-paths ["dist"]
      }
    }
  )
