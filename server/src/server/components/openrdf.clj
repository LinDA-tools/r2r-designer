(ns server.components.openrdf
  (:require
    [com.stuartsierra.component :as c]
    [taoensso.timbre :as timbre]
    [server.core.openrdf :refer :all])
  (:import
    org.openrdf.repository.http.HTTPRepository))

(timbre/refer-timbre)

(defrecord OpenRDF []
  c/Lifecycle

  (start [c]
    (info "starting openrdf ...")
    (reset! (:server c) (HTTPRepository. (:host c) (:repo c)))
    c) 

  (stop [c]
    (info "stopping openrdf ...")
    (reset! (:server c) nil)
    c))
  
(defn new-openrdf [opts]
  (map->OpenRDF {:server (atom nil)
                 :host (:host opts)
                 :repo (:repo opts)
                 :base-uri (:base-uri opts)
                 }))
