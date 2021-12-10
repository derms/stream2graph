#!/bin/bash

export GRAPH="friendNet"
export CONFIG_DIR="/home/tigergraph/config"
export GSQL="/home/tigergraph/tigergraph/app/cmd/gsql"


gsql_ls() {
    echo `$GSQL 'ls' ` 
}

HAS_GRAPH=$(gsql_ls | grep  "Graph $GRAPH")

if [ -z "$HAS_GRAPH" ]; then
  # No graph, so load vertifices
  echo "Creating graph $GRAPH"
  $GSQL $CONFIG_DIR/setup-graph.gsql 
fi

echo "Setup jobs"
$GSQL $CONFIG_DIR/setup-jobs.gsql

echo "Running jobs"
$GSQL $CONFIG_DIR/run-jobs.gsql
