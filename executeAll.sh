#!/bin/bash
DEMO_PROJECT_NAME=demo-project

tar -xf "$DEMO_PROJECT_NAME".tar.xz
git clone https://github.com/DaGeRe/peass.git && \
	cd peass && \
	./mvnw clean install -DskipTests -V

DEMO_HOME=$(pwd)/../$DEMO_PROJECT_NAME
DEMO_PROJECT_PEASS=../"$DEMO_PROJECT_NAME"_peass
EXECUTION_FILE=results/execute_"$DEMO_PROJECT_NAME".json
DEPENDENCY_FILE=results/deps_"$DEMO_PROJECT_NAME".json
CHANGES_DEMO_PROJECT=results/changes_"$DEMO_PROJECT_NAME".json
PROPERTY_FOLDER=results/properties_"$DEMO_PROJECT_NAME"/

RIGHT_SHA="$(cd "$DEMO_HOME" && git rev-parse HEAD)"

# It is assumed that $DEMO_HOME is set correctly and PeASS has been built!
echo ":::::::::::::::::::::SELECT:::::::::::::::::::::::::::::::::::::::::::"
./peass select -folder $DEMO_HOME

INITIALVERSION="bf6d4897d8b13dcdc23d0e29d9b3b1791dec9d34"
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
./peass measure -executionfile $EXECUTION_FILE -folder $DEMO_HOME -vms 5 -iterations 5 -warmup 5 -repetitions 5

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
./peass getchanges -data $DEMO_PROJECT_PEASS -dependencyfile $DEPENDENCY_FILE

#Check, if $CHANGES_DEMO_PROJECT contains the correct commit-SHA
TEST_SHA=$(grep -A1 'versionChanges" : {' $CHANGES_DEMO_PROJECT | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
if [ "$RIGHT_SHA" != "$TEST_SHA" ]
then
    echo "commit-SHA ("$RIGHT_SHA") is not equal to the SHA in $CHANGES_DEMO_PROJECT ("$TEST_SHA")!"
    cat results/statistics/"$DEMO_PROJECT_NAME".json
    exit 1
else
    echo "$CHANGES_DEMO_PROJECT contains the correct commit-SHA."
fi

# If minor updates to the project occur, the version name may change
VERSION=$(grep '"testcases" :' -B 1 $EXECUTION_FILE | tail -2 | head -1 | tr -d "\": {")
echo "VERSION: $VERSION"

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
./peass searchcause -vms 3 -iterations 5 -warmup 1 -repetitions 5 -version $VERSION \
    -test de.test.CalleeTest\#onlyCallMethod1 \
    -folder $DEMO_HOME \
    -executionfile $EXECUTION_FILE

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
./peass visualizerca -data $DEMO_PROJECT_PEASS -propertyFolder $PROPERTY_FOLDER

#Check, if a slowdown is detected for Callee#innerMethod
STATE=$(grep -A21 '"call" : "de.test.Callee#innerMethod",' results/$VERSION/de.test.CalleeTest_onlyCallMethod1.js \
    | grep '"state" : "SLOWER",' \
    | grep -o 'SLOWER')
if [ "$STATE" != "SLOWER" ]
then
    echo "State for Callee#innerMethod in de.test.CalleeTest#onlyCallMethod1.html has not the expected value SLOWER, but was $STATE!"
    cat results/$VERSION/de.test.CalleeTest_onlyCallMethod1.js
    exit 1
else
    echo "Slowdown is detected for Callee#innerMethod."
fi

SOURCE_METHOD_LINE=$(grep "Callee.method1_" results/$VERSION/de.test.CalleeTest_onlyCallMethod1.js -A 3 \
    | head -n -3 \
    | grep innerMethod)
if [[ "$SOURCE_METHOD_LINE" != *"innerMethod();" ]]
then
    echo "Line could not be detected - source reading probably failed."
    echo "Line: "
    echo "SOURCE_METHOD_LINE: $SOURCE_METHOD_LINE"
    exit 1
else
    echo "SOURCE_METHOD_LINE is correct."
fi
