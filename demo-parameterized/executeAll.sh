#!/bin/bash

DEMO_PROJECT_NAME=demo-project-parameterized

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
java -jar $PEASS_FILE select -folder $DEMO_HOME

INITIALCOMMIT="49f75e8877c2e9b7cf6b56087121a35fdd73ff8b"
checkInitialCommit $INITIALCOMMIT $DEPENDENCY_FILE

if [ ! -f "$EXECUTION_FILE" ]
then
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo "$EXECUTION_FILE could not be found!"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
fi

SELECTED_TESTCASES=$(cat $EXECUTION_FILE | grep "testcases" -A 1 | tail -n 1)
if [[ "$SELECTED_TESTCASES" != *"[ \"test(JUNIT_PARAMETERIZED-0)\", \"test(JUNIT_PARAMETERIZED-1)\" ]" ]]
then
	echo "test(JUNIT_PARAMETERIZED-0) and test(JUNIT_PARAMETERIZED-1) should be selected, but was: $SELECTED_TESTCASES"
	cat $EXECUTION_FILE
	exit 1
fi

echo ":::::::::::::::::::::MEASURE::::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE measure -executionfile $EXECUTION_FILE -folder $DEMO_HOME -vms 5 -iterations 5 -warmup 5 -repetitions 5

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE getchanges -data $DEMO_PROJECT_PEASS -staticSelectionFile $DEPENDENCY_FILE

checkChanges $COMMIT $CHANGES_DEMO_PROJECT $DEMO_PROJECT_NAME

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
echo "rcaStrategy is: $rcaStrategy"
java -jar $PEASS_FILE searchcause -vms 3 -iterations 5 -warmup 1 -repetitions 5 -commit $COMMIT \
    -test de.dagere.peass.ExampleTest\#test\(JUNIT_PARAMETERIZED-1\) \
    -folder $DEMO_HOME \
    -executionfile $EXECUTION_FILE \
    -rcaStrategy $rcaStrategy \
    -propertyFolder $PROPERTY_FOLDER

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
java -jar $PEASS_FILE visualizerca -data $DEMO_PROJECT_PEASS -propertyFolder $PROPERTY_FOLDER

#Check, if a slowdown is detected for Callee#innerMethod
STATE=$(grep -A21 '"call" : "de.dagere.peass.Callee#innerMethod",' "results/$COMMIT/de.dagere.peass.ExampleTest_test(JUNIT_PARAMETERIZED-1).js" \
    | grep '"state" : "SLOWER",' \
    | grep -o 'SLOWER')
if [ "$STATE" != "SLOWER" ]
then
    echo "State for Callee#innerMethod in de.dagere.peass.ExampleTest_test(JUNIT_PARAMETERIZED-1).js has not the expected value SLOWER, but was $STATE!"
    cat "results/$COMMIT/de.dagere.peass.ExampleTest_test(JUNIT_PARAMETERIZED-1).js"
    exit 1
else
    echo "Slowdown is detected for Callee#innerMethod."
fi

SOURCE_METHOD_LINE=$(grep "Callee.method1_" "results/$COMMIT/de.dagere.peass.ExampleTest_test(JUNIT_PARAMETERIZED-1).js" -A 3 \
    | head -n 3 \
    | grep innerMethod)
if [[ "$SOURCE_METHOD_LINE" != *"innerMethod(value);" ]]
then
    echo "Line could not be detected - source reading probably failed."
    echo "SOURCE_METHOD_LINE: $SOURCE_METHOD_LINE"
    exit 1
else
    echo "SOURCE_METHOD_LINE is correct."
fi
