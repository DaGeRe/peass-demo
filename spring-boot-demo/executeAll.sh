#!/bin/bash

DEMO_PROJECT_NAME=demo-project-spring-boot

if [ "$#" -lt 1 ]; then
	branch="main"
else
	branch=$1
fi

if [ ! -z $2 ]; then
    rcaStrategy=$2
else
    rcaStrategy="COMPLETE"
fi

tar -xf "$DEMO_PROJECT_NAME".tar.zstd

source ../common-functions.sh

DEMO_HOME=$(pwd)/$DEMO_PROJECT_NAME
DEMO_PROJECT_PEASS=$(pwd)/"$DEMO_PROJECT_NAME"_peass
EXECUTION_FILE=results/traceTestSelection_"$DEMO_PROJECT_NAME".json
DEPENDENCY_FILE=results/staticTestSelection_"$DEMO_PROJECT_NAME".json
CHANGES_DEMO_PROJECT=results/changes.json
PROPERTY_FOLDER=results/properties_"$DEMO_PROJECT_NAME"/

COMMIT="$(cd "$DEMO_HOME" && git rev-parse HEAD)"

# It is assumed that $DEMO_HOME is set correctly and PeASS has been built!
echo ":::::::::::::::::::::SELECT:::::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE select -folder $DEMO_HOME

INITIALCOMMIT="092c27120c70c1e27a8c4319f53bc59160ba6c89"
checkInitialCommit $INITIALCOMMIT $DEPENDENCY_FILE

INITIAL_TEST=$(grep "initialDependencies" -A 1 $DEPENDENCY_FILE | grep "ExampleTest")

echo $INITIAL_TEST

if [ -z "$INITIAL_TEST" ]
then
    echo "Loading the dependencies did not work: $INITIAL_TEST"
    exit 1
fi


if [ ! -f "$EXECUTION_FILE" ]
then
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo "$EXECUTION_FILE could not be found!"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
fi

echo ":::::::::::::::::::::MEASURE::::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE measure -executionFile $EXECUTION_FILE -folder $DEMO_HOME -vms 5 -iterations 5 -warmup 5 -repetitions 5

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE getchanges -data $DEMO_PROJECT_PEASS -staticSelectionFile $DEPENDENCY_FILE

checkChanges $COMMIT $CHANGES_DEMO_PROJECT $DEMO_PROJECT_NAME

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
echo "rcaStrategy is: $rcaStrategy"
java -jar $PEASS_FILE searchcause -vms 3 -iterations 5 -warmup 1 -repetitions 5 -commit $COMMIT \
    -test de.dagere.peass.ExampleTest\#test \
    -folder $DEMO_HOME \
    -executionFile $EXECUTION_FILE \
    -rcaStrategy $rcaStrategy \
    -propertyFolder $PROPERTY_FOLDER

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE visualizerca -data $DEMO_PROJECT_PEASS -propertyFolder $PROPERTY_FOLDER

checkResultJS $COMMIT
