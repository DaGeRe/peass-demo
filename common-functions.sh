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
