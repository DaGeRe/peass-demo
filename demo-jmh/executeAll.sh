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

VERSION="$(cd "$DEMO_HOME" && git rev-parse HEAD)"

# It is assumed that $DEMO_HOME is set correctly and PeASS has been built!
echo ":::::::::::::::::::::SELECT:::::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE select -folder $DEMO_HOME -workloadType JMH

INITIALVERSION="db0217b4aa32236d3fea5f88afa24069dbe8dba3"
INITIAL_SELECTED=$(grep "initialversion" -A 1 $DEPENDENCY_FILE | grep "\"version\"" | tr -d " \"," | awk -F':' '{print $2}')
if [ "$INITIAL_SELECTED" != "$INITIALVERSION" ]
then
	echo "Initialversion should be $INITIALVERSION, but was $INITIAL_SELECTED"
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
java -jar $PEASS_FILE measure -executionfile $EXECUTION_FILE -folder $DEMO_HOME -workloadType JMH -vms 3 -iterations 5 -warmup 5 -repetitions 5

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE getchanges -data $DEMO_PROJECT_PEASS -staticSelectionFile $DEPENDENCY_FILE

#Check, if $CHANGES_DEMO_PROJECT contains the correct commit-SHA
TEST_SHA=$(grep -A1 'versionChanges" : {' $CHANGES_DEMO_PROJECT | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
if [ "$VERSION" != "$TEST_SHA" ]
then
    echo "commit-SHA ("$VERSION") is not equal to the SHA in $CHANGES_DEMO_PROJECT ("$TEST_SHA")!"
    cat results/statistics/"$DEMO_PROJECT_NAME".json
    exit 1
else
    echo "$CHANGES_DEMO_PROJECT contains the correct commit-SHA."
fi

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE searchcause -vms 3 -iterations 5 -warmup 1 -repetitions 5 -version $VERSION \
    -workloadType JMH \
    -test de.dagere.peass.ExampleBenchmarkClazz\#calleeMethod \
    -folder $DEMO_HOME \
    -executionfile $EXECUTION_FILE

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE visualizerca -data $DEMO_PROJECT_PEASS -propertyFolder $PROPERTY_FOLDER

#Check, if a slowdown is detected for Callee#innerMethod
STATE=$(grep -A21 '"call" : "de.dagere.peass.Callee#innerMethod",' results/$VERSION/de.dagere.peass.ExampleBenchmarkClazz_calleeMethod.js \
    | grep '"state" : "SLOWER",' \
    | grep -o 'SLOWER')
if [ "$STATE" != "SLOWER" ]
then
    echo "State for Callee#innerMethod in de.dagere.peass.ExampleBenchmarkClazz_calleeMethod.js has not the expected value SLOWER, but was $STATE!"
    cat results/$VERSION/de.dagere.peass.ExampleBenchmarkClazz_calleeMethod.js
    exit 1
else
    echo "Slowdown is detected for Callee#innerMethod."
fi

SOURCE_METHOD_LINE=$(grep "Callee.method1_" results/$VERSION/de.dagere.peass.ExampleBenchmarkClazz_calleeMethod.js -A 3 \
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
