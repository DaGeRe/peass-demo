#!/bin/bash
tar -xf demo-project.tar.xz
git clone https://github.com/DaGeRe/peass.git && \
	cd peass && \
	./mvnw clean install -DskipTests=true -V

DEMO_HOME=$(pwd)/../demo-project
DEMO_PROJECT_PEASS=../demo-project_peass
EXECUTION_FILE=results/execute_demo-project.json
DEPENDENCY_FILE=results/deps_demo-project.json
CHANGES_DEMO_PROJECT=results/changes_demo-project.json

RIGHT_SHA="$(cd "$DEMO_HOME" && git rev-parse HEAD)"

# It is assumed that $DEMO_HOME is set correctly and PeASS has been built!
echo ":::::::::::::::::::::SELECT:::::::::::::::::::::::::::::::::::::::::::"
./peass select -folder $DEMO_HOME

if [ ! -f "$EXECUTION_FILE" ]
then
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo "$EXECUTION_FILE could not be found!"
    echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
fi

echo ":::::::::::::::::::::MEASURE::::::::::::::::::::::::::::::::::::::::::"
./peass measure -executionfile $EXECUTION_FILE -folder $DEMO_HOME -iterations 1 -warmup 0 -repetitions 1 -vms 2

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
./peass getchanges -data $DEMO_PROJECT_PEASS -dependencyfile $DEPENDENCY_FILE

#Check, if $CHANGES_DEMO_PROJECT contains the correct commit-SHA
TEST_SHA=$(grep -A1 'versionChanges" : {' $CHANGES_DEMO_PROJECT | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
if [ "$RIGHT_SHA" != "$TEST_SHA" ]
then
    echo "commit-SHA is not equal to the SHA in $CHANGES_DEMO_PROJECT"
    cat results/statistics/demo-project.json
    exit 1
else
    echo "$CHANGES_DEMO_PROJECT contains the correct commit-SHA."
fi

# If minor updates to the project occur, the version name may change
VERSION=$(grep '"testcases" :' -B 1 $EXECUTION_FILE | head -n 1 | tr -d "\": {")
echo "VERSION: $VERSION"

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
./peass searchcause -vms 5 -iterations 1 -warmup 0 -version $VERSION -test de.test.CalleeTest\#onlyCallMethod1 -folder $DEMO_HOME -executionfile $EXECUTION_FILE

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
./peass visualizerca -data $DEMO_PROJECT_PEASS -propertyFolder results/properties_demo-project/

#Check, if a slowdown is detected for innerMethod
STATE=$(grep '"call" : "de.test.Callee#innerMethod",\|state' results/$VERSION/de.test.CalleeTest_onlyCallMethod1.js | grep "innerMethod" -A 1 | grep '"state" : "SLOWER",' | grep -o 'SLOWER')
if [ "$STATE" != "SLOWER" ]
then
    echo "State for de.test.Callee#innerMethod in de.test.CalleeTest#onlyCallMethod1.html has not the expected value SLOWER, but was $STATE!"
    cat results/$VERSION/de.test.CalleeTest_onlyCallMethod1.js
    exit 1
else
    echo "Slowdown is detected for innerMethod."
fi

SOURCE_METHOD_LINE=$(grep "de.test.Callee.method1_" results/$VERSION/de.test.CalleeTest_onlyCallMethod1.js -A 3 | head -n 3 | grep innerMethod)
if [[ "$SOURCE_METHOD_LINE" != *"innerMethod();" ]]
then
    echo "Line could not be detected - source reading probably failed."
    echo "Line: "
    echo "SOURCE_METHOD_LINE: $SOURCE_METHOD_LINE"
    exit 1
fi
