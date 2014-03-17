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
    [ring-mock "0.1.5"]
    ]
  :plugins [[lein-ring "0.8.10"]]
  :ring {:handler server.handler/app}
  :profiles {
    :dev {
      :dependencies [
        [org.clojure/tools.namespace "0.2.4"]
        [javax.servlet/servlet-api "2.5"]
        ]
      :source-paths ["server/dev" "server/src"]
      }
    }
  )
