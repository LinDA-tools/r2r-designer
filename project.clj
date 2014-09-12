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
    [org.clojure/java.classpath "0.2.2"]
    [com.stuartsierra/component "0.2.1"]
    [compojure "1.1.8"]
    [ring-server "0.3.1" :exclusions [org.clojure/java.classpath]]
    [ring-cors "0.1.1"]
    [clj-http "0.9.2"]
    [edu.ucdenver.ccp/kr-sesame-core "1.4.12" :exclusions [org.clojure/java.classpath ]]
    [com.taoensso/timbre "3.2.1"]
    [com.jolbox/bonecp "0.8.0.RELEASE"]
    [org.postgresql/postgresql "9.3-1101-jdbc41"]
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
        [ring-mock "0.1.5"]
        [ring/ring-devel "1.3.0" :exclusions [org.clojure/tools.namespace org.clojure/java-classpath]]
        ]
      :source-paths ["server/dev"]
      :aot [dev]
      :main dev
      }
    }
  :aot [server.system]
  :main server.system
  )
