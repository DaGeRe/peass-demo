#!/bin/bash

# It is assumed that $PEASS_PROJECT is set correctly and PeASS has been built!

tar -xvf demo-project.tar.xz
$PEASS_HOME/./peass select -folder demo-project
$PEASS_HOME/./peass measure -executionfile results/execute_demo-project.json -folder demo-project -iterations 1 -warmup 0 -repetitions 1 -vms 2
$PEASS_HOME/./peass getchanges -data demo-project_peass/ -dependencyfile results/deps_demo-project.json
