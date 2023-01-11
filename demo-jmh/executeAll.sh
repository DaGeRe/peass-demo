#!/bin/bash

DEMO_PROJECT_NAME=demo-project-jmh

if [ "$#" -ne 1 ]; then
	branch="main"
else
	branch=$1
fi

tar -xf "$DEMO_PROJECT_NAME".tar.xz

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
java -jar $PEASS_FILE select -folder $DEMO_HOME -workloadType JMH

INITIALCOMMIT="db0217b4aa32236d3fea5f88afa24069dbe8dba3"
checkInitialCommit $INITIALCOMMIT $DEPENDENCY_FILE


if [ ! -f "$EXECUTION_FILE" ]
then
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo "$EXECUTION_FILE could not be found!"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
fi

echo ":::::::::::::::::::::MEASURE::::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE measure -executionFile $EXECUTION_FILE -folder $DEMO_HOME -workloadType JMH -vms 5 -iterations 5 -warmup 5 -repetitions 10

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE getchanges -data $DEMO_PROJECT_PEASS -staticSelectionFile $DEPENDENCY_FILE

checkChanges $COMMIT $CHANGES_DEMO_PROJECT $DEMO_PROJECT_NAME

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE searchcause -vms 3 -iterations 5 -warmup 1 -repetitions 5 -commit $COMMIT \
    -workloadType JMH \
    -test de.dagere.peass.ExampleBenchmarkClazz\#calleeMethod \
    -folder $DEMO_HOME \
    -executionFile $EXECUTION_FILE

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE visualizerca -data $DEMO_PROJECT_PEASS -propertyFolder $PROPERTY_FOLDER

checkChanges $COMMIT $CHANGES_DEMO_PROJECT $DEMO_PROJECT_NAME

SOURCE_METHOD_LINE=$(grep "Callee.method1_" results/$COMMIT/de.dagere.peass.ExampleBenchmarkClazz/calleeMethod.js -A 3 \
    | head -n 3 \
    | grep innerMethod)
if [[ "$SOURCE_METHOD_LINE" != *"innerMethod();" ]]
then
    echo "Line could not be detected - source reading probably failed."
    echo "SOURCE_METHOD_LINE: $SOURCE_METHOD_LINE"
    exit 1
else
    echo "SOURCE_METHOD_LINE is correct."
fi
