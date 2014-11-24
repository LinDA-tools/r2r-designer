(ns server.core.sparqlify
  (:require
    [clojure.java.shell :as sh]
    [clojure.java.io :as io]
    [taoensso.timbre :as timbre])
  (:import 
    java.io.File
    org.aksw.jena_sparql_api.core.utils.QueryExecutionUtils
    org.aksw.commons.util.MapReader
    [org.aksw.sparqlify.config.v0_2.bridge SchemaProviderImpl SyntaxBridge]
    org.aksw.sparqlify.core.RdfViewSystemOld
    org.aksw.sparqlify.core.algorithms.CandidateViewSelectorImpl
    org.aksw.sparqlify.core.algorithms.OpMappingRewriterImpl
    org.aksw.sparqlify.core.algorithms.ViewDefinitionNormalizerImpl
    org.aksw.sparqlify.core.interfaces.OpMappingRewriter
    org.aksw.sparqlify.util.SparqlifyUtils
    org.aksw.sparqlify.web.SparqlifyCliHelper
    org.apache.commons.cli.GnuParser
    org.apache.commons.cli.Options
    org.apache.jena.riot.out.NTriplesWriter
    ))

(timbre/refer-timbre)

(defn mapping-to-file [mapping]
  (let [mapping-file (if mapping (File/createTempFile "mapping" ".sml"))] 
    (when mapping-file 
      (spit mapping-file mapping))
    mapping-file))

(defn init-sparqlify! []
  (RdfViewSystemOld/initSparqlifyFunctions))

;; pseudo-parse pseudo-options into config [...]
(defn mapping-to-config [mapping-file]
  (let [options (doto (Options.) (.addOption "m" "mapping" true ""))
        parser (GnuParser.)
        cmd (.parse parser options (into-array String ["-m" mapping-file]))
        config (SparqlifyCliHelper/parseSmlConfigs cmd nil)]
    config))

;; sadly cannot easily kill sub-processes when invoking jar's through shell but ... common, seriously guys?
;; rough rewrite of sparqlify-core's main; most of the config is not needed?
(defn config-sparqlify [c mapping-file]
  ;; (init-sparqlify!)
  (let [pool @(:pool (:datasource c))
        config (mapping-to-config mapping-file)
        ;; ers (SparqlifyUtils/createExprRewriteSystem)
        ;; typeSystem (.getTypeSystem ers)
        ;; typeAliases (MapReader/readFromResource "/type-map.h2.tsv")
        ]
    ;; (with-open [conn (.getConnection pool)]
    ;;   (let [schemaProvider (SchemaProviderImpl. conn typeSystem typeAliases)
    ;;         syntaxBridge (SyntaxBridge. schemaProvider)
    ;;         mappingOps (SparqlifyUtils/createDefaultMappingOps ers)
    ;;         opMappingRewriter (OpMappingRewriterImpl. mappingOps)
    ;;         candidateViewSelector (CandidateViewSelectorImpl. mappingOps (ViewDefinitionNormalizerImpl.))]))
    (SparqlifyUtils/createDefaultSparqlifyEngine pool config nil nil)))

(defn start-sparql-endpoint! [c mapping-file]
  (let [port (:port c)
        qef (config-sparqlify c mapping-file)]
    (org.aksw.sparqlify.web.Main/createSparqlEndpoint qef port)))

(defn sparqlify-dump [c mapping-file]
  (let [qef (config-sparqlify c mapping-file)
        it (QueryExecutionUtils/createIteratorDumpTriples qef)
        f (File/createTempFile "dump" ".n3")]
    (with-open [out (io/output-stream f)] 
      (NTriplesWriter/write out it))
    f))
