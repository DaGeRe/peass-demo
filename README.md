# PeASS Demo

This demo shows how to detect a simple performance change and its cause by PeASS. The `demo-project` contains three versions, where `CalleeTest` calls `Callee`. In the 3rd version b02c92a, `Callee#innerMethod` contains a longer call to `Thread.sleep` than before, therefore, performance gets worse in this version.

If you just want to see the results, you can also immediately open `example_results/peass/results/b02c92af73e3297be617f4c973a7a63fb603565b/de.test.CalleeTest_onlyCallMethod1.html`.

## Prerequisites

In current development state, it is recommended to use the latest development version of PeASS. The following commands require (at least) installed OpenJDK 8, maven and tar and have been tried on Ubuntu 18.04 and 20.04.

For installing the latest development version of PeASS, first install the current latest development version of KoPeMe (`git clone https://github.com/DaGeRe/kopeme.git && cd kopeme && git checkout develop && mvn clean install`). Afterwards, install PeASS itself by running `git clone https://github.com/DaGeRe/peass.git && cd peass && mvn clean install` in order to clone and build PeASS (optionally add `-DskipTests=true` the `mvn`-call to speed up building).

To get the example running, untar the example project using `tar -xvf demo-project.tar.xz` (which is a git project itself and is therefore managed inside this repo as tar). For the following commands, we assume that you are in the peass-folder and that the demo-project is in the folder one level above. So you should got:

kopeme
peass
peass-demo/demo-project
peass-demo/demo-project.tar.xz

and than run cd peass.

## Executing the Regression Test Selection

Run `./peass select -folder ../peass-demo/demo-project/` (takes ~1 minute). After the selection, you'll find in `results/execute_demo-project.json` an executionfile for the project, which specifies which tests could have changed performance based on source code analysis.

## Executing the Measurement and Getting the Changes

Run `./peass measure -executionfile results/execute_demo-project.json -folder ../peass-demo/demo-project -iterations 1 -warmup 0 -repetitions 1 -vms 2` (takes ~30 seconds) in order to obtain performance measurements. For real examples, higher execution times are needed, but for the demo case, this is sufficient.

Afterwards, run `./peass getchanges -data ../peass-demo/demo-project_peass/ -dependencyfile results/deps_demo-project.json` (takes ~1 second) in order to identify the changes. Now in `results/changes_demo-project.json`, all changes are listed. As expected, b02c92af73e3297be617f4c973a7a63fb603565b contains a change in the test onlyCallMethod1.

## Executing the Root Cause Analysis

Execute `./peass searchcause -vms 2 -iterations 1 -warmup 0 -version b02c92af73e3297be617f4c973a7a63fb603565b -test de.test.CalleeTest#onlyCallMethod1 -folder ../peass-demo/demo-project -executionfile results/execute_demo-project.json` (takes ~8 minutes) in order to get changes.

To finally get the root cause analysis visualization, run `./peass visualizerca -data ../peass-demo/demo-project_peass/ -propertyFolder results/properties_demo-project/`. Now, results/b02c92af73e3297be617f4c973a7a63fb603565b contains the file de.test.CalleeTest_onlyCallMethod1.html which you can visualize in your browser. You'll see that CalleeTest#onlyCallMethod1, Callee#method1 and Callee#innerMethod are red - therefore, all this have gotten slower and Callee#innerMethod is very likely the root cause of the performance change.

## Spotting Bugs

In case any step did not work, you can check whether the results (both in `demo-project_peass`, mostly results for potential remote execution and debugging, and in `results`, mostly results which are relevant to the developer) look correct. If this does not work, do not hesitate to contact the maintainer. 
