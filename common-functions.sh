function checkInitialCommit {
	expectedCommit=$1
	dependencyfile=$2
	
	INITIAL_SELECTED=$(grep "initialcommit" -A 1 $dependencyfile | grep "\"commit\"" | tr -d " \"," | awk -F':' '{print $2}')
	if [ "$INITIAL_SELECTED" != "$expectedCommit" ]
	then
		echo "Initial commit should be $expectedCommit, but was $INITIAL_SELECTED"
		exit 1
	fi
}

echo "Cloning branch $branch"
if [ ! -d ../peass ]
then
	startDir=$(pwd)
	cd ..
	git clone -b $branch https://github.com/DaGeRe/peass.git 
	cd peass && ./mvnw clean install -DskipTests -V -P buildStarter
	cd $startDir
fi

PEASS_PROJECT=../peass

PEASS_FILE=$PEASS_PROJECT/starter/target/peass-starter-*-SNAPSHOT.jar
