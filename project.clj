(defproject r2r-designer.server "0.1.0-SNAPSHOT"
  :description "server component for the r2r-designer"
  :url "http://linda-project.eu"
  :license {
    :name "MIT"
    :url "http://opensource.org/licenses/MIT"
    }
  :dependencies [
    [org.clojure/clojure "1.6.0"]
    [org.clojure/java.jdbc "0.3.3"]
    [org.clojure/data.json "0.2.4"]
    [org.clojure/core.async "0.1.278.0-76b25b-alpha"]
    [com.stuartsierra/component "0.2.1"]
    [compojure "1.1.6"]
    [log4j/log4j "1.2.17"]
    [ring-server "0.3.1"]
    [ring-cors "0.1.0"]
    [clj-http "0.9.1"]
    [org.clojure/data.json "0.2.4"]
    [org.clojure/core.async "0.1.278.0-76b25b-alpha"]
    [edu.ucdenver.ccp/kr-sesame-core "1.4.8"]
    [com.taoensso/timbre "3.2.0"]
    [com.jolbox/bonecp "0.8.0.RELEASE"]
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
        [org.postgresql/postgresql "9.2-1004-jdbc41"]
        [ring-mock "0.1.5"]
        [ring/ring-devel "1.2.1"]
        ]
      :source-paths ["server/dev"]
      }
    }
  )
