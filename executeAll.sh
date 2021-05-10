#!/bin/bash
set -e
tar -xf demo-project.tar.xz
git clone https://github.com/DaGeRe/peass.git && \
	cd peass && \
	DEMO_HOME=$(pwd)/../demo-project && \
	./mvnw clean install -DskipTests=true -V

right_sha="$(cd ../demo-project && git rev-parse HEAD)"

# It is assumed that $DEMO_HOME is set correctly and PeASS has been built!
echo ":::::::::::::::::::::SELECT:::::::::::::::::::::::::::::::::::::::::::"
./peass select -folder $DEMO_HOME

if [ ! -f results/execute_demo-project.json ]
then
	echo "Main Logs"
	ls ../demo-project_peass/
	ls ../demo-project_peass/logs/
	echo "projektTemp"
	ls ../demo-project_peass/projectTemp/
	ls ../demo-project_peass/projectTemp/1_peass/
	ls ../demo-project_peass/projectTemp/1_peass/logs/
	cat ../demo-project_peass/projectTemp/1_peass/logs/bf6d4897d8b13dcdc23d0e29d9b3b1791dec9d34/*/* 
	cat ../demo-project_peass/projectTemp/1_peass/logs/$right_sha/*/*
	exit 1
fi

echo ":::::::::::::::::::::MEASURE::::::::::::::::::::::::::::::::::::::::::"
./peass measure -executionfile results/execute_demo-project.json -folder $DEMO_HOME -iterations 1 -warmup 0 -repetitions 1 -vms 2

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
./peass getchanges -data ../demo-project_peass/ -dependencyfile results/deps_demo-project.json

#Check, if changes_demo-project.json contains the correct commit-SHA
test_sha=$(grep -A1 'versionChanges" : {' results/changes_demo-project.json | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
if [ "$right_sha" != "$test_sha" ]
then
    echo "commit-SHA is not equal to the SHA in changes_demo-project.json!"
    cat results/statistics/demo-project.json
    exit 1
else
    echo "changes_demo-project.json contains the correct commit-SHA."
fi

# If minor updates to the project occur, the version name may change
version=$(cat results/execute_demo-project.json | grep "versions" -A 4 | tail -n 1 | tr -d "\": {")
echo "Version: $version"

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
./peass searchcause -vms 5 -iterations 1 -warmup 0 -version $version -test de.test.CalleeTest\#onlyCallMethod1 -folder $DEMO_HOME -executionfile results/execute_demo-project.json

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
./peass visualizerca -data ../demo-project_peass -propertyFolder results/properties_demo-project/

#Check, if a slowdown is detected for innerMethod
state=$(grep '"call" : "de.test.Callee#innerMethod",\|state' results/$version/de.test.CalleeTest_onlyCallMethod1.js | grep "innerMethod" -A 1 | grep '"state" : "SLOWER",' | grep -o 'SLOWER')
if [ "$state" != "SLOWER" ]
then
    echo "State for de.test.Callee#innerMethod in de.test.CalleeTest#onlyCallMethod1.html has not the expected value SLOWER, but was $state!"
    cat results/$version/de.test.CalleeTest_onlyCallMethod1.js
    exit 1
else
    echo "Slowdown is detected for innerMethod."
fi

sourceMethodLine=$(grep "de.test.Callee.method1_" results/$version/de.test.CalleeTest_onlyCallMethod1.js -A 3 | head -n 3 | grep innerMethod)
if [[ "$sourceMethodLine" != *"innerMethod();" ]]
then
    echo "Line could not be detected - source reading probably failed."
    echo "Line: "
    echo $sourceMethodLine
    exit 1
fi
