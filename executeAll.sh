#!/bin/bash
set -e
tar -xf demo-project.tar.xz
git clone https://github.com/DaGeRe/peass.git && \
	cd peass && \
	DEMO_HOME=$(pwd)/../demo-project && \
	mvn clean install -DskipTests=true

# It is assumed that $PEASS_HOME is set correctly and PeASS has been built!
echo ":::::::::::::::::::::SELECT:::::::::::::::::::::::::::::::::::::::::::"
./peass select -folder $DEMO_HOME

echo ":::::::::::::::::::::MEASURE::::::::::::::::::::::::::::::::::::::::::"
./peass measure -executionfile results/execute_demo-project.json -folder $DEMO_HOME -iterations 1 -warmup 0 -repetitions 1 -vms 2

echo "::::::::::::::::::::GETCHANGES::::::::::::::::::::::::::::::::::::::::"
./peass getchanges -data ../demo-project_peass/ -dependencyfile results/deps_demo-project.json

echo "::::::::::::::::::::SEARCHCAUSE:::::::::::::::::::::::::::::::::::::::"
./peass searchcause -vms 2 -iterations 1 -warmup 0 -version 9caed514e0759dbfa4ef29acca78787e34d99975 -test de.test.CalleeTest\#onlyCallMethod1 -folder $DEMO_HOME -executionfile results/execute_demo-project.json 

echo "::::::::::::::::::::VISUALIZERCA::::::::::::::::::::::::::::::::::::::"
./peass visualizerca -data ../demo-project_peass -propertyFolder results/properties_demo-project/

#Check, if changes_demo-project.json contains the correct commit-SHA
cd ../demo-project
right_sha="$(git rev-parse HEAD)"
cd ../peass
(
	test_sha=$(grep -A1 'versionChanges" : {' results/changes_demo-project.json | grep -v '"versionChanges' | grep -Po '"\K.*(?=")')
	if [ "$right_sha" != "$test_sha" ]
		then
			echo "commit-SHA is not equal to the SHA in changes_demo-project.json!"
			exit 1
		else
			echo "changes_demo-project.json contains the correct commit-SHA."
	fi
) && true

if [ $? -ne 0 ]
	then exit 1
fi

#Check, if a slowdown is detected for innerMethod
(
	state=$(grep -A20 '"call" : "de.test.Callee#innerMethod",' results/9caed514e0759dbfa4ef29acca78787e34d99975/de.test.CalleeTest#onlyCallMethod1.html | grep '"state" : "SLOWER",' | grep -o 'SLOWER')
	if [ "$state" != "SLOWER" ]
		then
			echo "State for de.test.Callee#innerMethod in de.test.CalleeTest#onlyCallMethod1.html has not the expected value SLOWER!"
			exit 1
		else
			echo "Slowdown is detected for innerMethod."
	fi
) && true
