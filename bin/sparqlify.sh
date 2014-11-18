#!/bin/bash
ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
SPARQLIFY_JAR=$ABSPATH/../server/lib/sparqlify-debian-cli-0.6.13-SNAPSHOT.jar

java -cp $SPARQLIFY_JAR org.aksw.sparqlify.web.Main $@
