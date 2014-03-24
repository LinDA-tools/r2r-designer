(defproject r2r-designer.server "0.1.0-SNAPSHOT"
  :description "server component for the r2r-designer"
  :url "http://linda-project.eu"
  :license {
    :name "MIT"
    :url "http://opensource.org/licenses/MIT"
    }
  :dependencies [
    [org.clojure/clojure "1.5.1"]
    [compojure "1.1.6"]
    [org.clojure/java.jdbc "0.3.3"]
    [log4j/log4j "1.2.17"]
    [org.clojure/tools.logging "0.2.6"]
    [ring-server "0.3.1"]
    [ring-cors "0.1.0"]
    ]
  :plugins [[lein-ring "0.8.10"]]
  :ring {:handler server.handler/app}
  :source-paths ["server/src"]
  :test-paths ["server/test"]
  :resource-paths ["server/resource"]
  :profiles {
    :dev {
      :dependencies [
        [org.clojure/tools.namespace "0.2.4"]
        [javax.servlet/servlet-api "2.5"]
        [org.hsqldb/hsqldb "1.8.0.10"]
        [ring-mock "0.1.5"]
        [ring/ring-devel "1.2.1"]
        ]
      :source-paths ["server/dev"]
      }
    }
  )
