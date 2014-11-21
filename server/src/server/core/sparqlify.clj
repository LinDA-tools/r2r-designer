(ns server.core.sparqlify
  (:require
    [clojure.java.shell :as sh]
    [clojure.java.io :as io]
    [taoensso.timbre :as timbre])
  (:import 
    java.io.File
    java.sql.Connection
    javax.sql.DataSource
    org.aksw.commons.util.MapReader
    org.aksw.sparqlify.config.syntax.Config
    org.aksw.sparqlify.config.v0_2.bridge.ConfiguratorCandidateSelector
    org.aksw.sparqlify.config.v0_2.bridge.SchemaProvider
    org.aksw.sparqlify.config.v0_2.bridge.SchemaProviderImpl
    org.aksw.sparqlify.config.v0_2.bridge.SyntaxBridge
    org.aksw.sparqlify.core.RdfViewSystemOld
    org.aksw.sparqlify.core.algorithms.CandidateViewSelectorImpl
    org.aksw.sparqlify.core.algorithms.OpMappingRewriterImpl
    org.aksw.sparqlify.core.algorithms.ViewDefinitionNormalizerImpl
    org.aksw.sparqlify.core.cast.TypeSystem
    org.aksw.sparqlify.core.domain.input.ViewDefinition
    org.aksw.sparqlify.core.interfaces.CandidateViewSelector
    org.aksw.sparqlify.core.interfaces.MappingOps
    org.aksw.sparqlify.core.interfaces.OpMappingRewriter
    org.aksw.sparqlify.core.sparql.QueryEx
    org.aksw.sparqlify.core.sparql.QueryExecutionFactoryEx
    org.aksw.sparqlify.core.sparql.QueryFactoryEx
    org.aksw.sparqlify.util.ExprRewriteSystem
    org.aksw.sparqlify.util.SparqlifyUtils
    org.aksw.sparqlify.validation.LoggerCount
    org.aksw.sparqlify.web.Main
    org.aksw.sparqlify.web.SparqlifyCliHelper
    org.apache.commons.cli.CommandLine
    org.apache.commons.cli.CommandLineParser
    org.apache.commons.cli.GnuParser
    org.apache.commons.cli.HelpFormatter
    org.apache.commons.cli.Options
    org.apache.jena.riot.out.NQuadsWriter
    org.apache.jena.riot.out.NTriplesWriter
    org.eclipse.jetty.server.Server
    org.eclipse.jetty.servlet.ServletContextHandler
    org.eclipse.jetty.servlet.ServletHolder
    ))

(timbre/refer-timbre)

(defn sparqlify-dump [c mapping-file]
  (let [db-spec @(:spec (:database c))
        args ["./bin/sparqlify.sh" "-D" 
              "-m" mapping-file 
              "-h" (:host db-spec) 
              "-d" (:name db-spec) 
              "-U" (:username db-spec) 
              (if (seq (:password db-spec)) "-W") (if (:password db-spec) (:password db-spec))]
        out (:out (apply sh/sh (remove nil? args)))
        f (File/createTempFile "dump" ".n3")]
    (spit f out)
    f))

;; sadly cannot easily kill sub-processes when invoking jar's through shell but ... common, seriously guys?
;; rough rewrite of sparqlify-core's main
(defn start-sparqlify [c mapping-file port]
  (RdfViewSystemOld/initSparqlifyFunctions)
  (let [ds @(:datasource (:database c))
        options (doto (Options.) (.addOption "m" "mapping" true ""))
        parser (GnuParser.)
        cmd (.parse parser options (into-array String ["-m" mapping-file]))
        config (SparqlifyCliHelper/parseSmlConfigs cmd nil)
        ers (SparqlifyUtils/createExprRewriteSystem)
        typeSystem (.getTypeSystem ers)
        typeAliases (MapReader/readFromResource "/type-map.h2.tsv")]
    (with-open [conn (.getConnection ds)]
      (let [schemaProvider (SchemaProviderImpl. conn typeSystem typeAliases)
            syntaxBridge (SyntaxBridge. schemaProvider)
            mappingOps (SparqlifyUtils/createDefaultMappingOps ers)
            opMappingRewriter (OpMappingRewriterImpl. mappingOps)
            candidateViewSelector (CandidateViewSelectorImpl. mappingOps (ViewDefinitionNormalizerImpl.))
            qef (SparqlifyUtils/createDefaultSparqlifyEngine ds config nil nil)
            server (Main/createSparqlEndpoint qef port)]
        (.start server)
        server))))
