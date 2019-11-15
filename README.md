# PeASS Demo

This demo shows how to detect a simple performance change and its cause by PeASS. The `demo-project` contains three versions, where `CalleeTest` calls `Callee`. In the 3rd version 9caed51, `Callee#innerMethod` contains a longer call to `Thread.sleep` than before, therefore, performance gets worse in this version.

If you just want to see the results, you can also immediately open `example_results/results/de.test.CalleeTest#onlyCallMethod1.html`.

## Prerequisites

First, install a tweaked Kieker 1.13 by running `git clone https://github.com/DaGeRe/kieker.git -b 1_13_tweak && cd kieker && ./install.sh`. 

Afterwards, install PeASS itself by running `git clone https://github.com/DaGeRe/peass.git && cd peass && mvn clean install` in order to clone and build PeASS.

Optionally, you can now get autocompletion in bash by running `. peass_completion`.

To get the example running, untar the example project using `tar -xvf demo-project.tar.xz` (which is a git project itself and is therefore managed inside this repo as tar).

## Executing the Regression Test Selection

Run `./peass select -folder ../demo-project/` (takes ~1 minute). After the selection, you'll find in `results/execute_demo-project.json` an executionfile for the project, which specifies which tests could have changed performance based on source code analysis.

## Executing the Measurement and Getting the Changes

Run `./peass measure -executionfile results/execute_demo-project.json -folder ../demo-project -iterations 1 -warmup 0 -repetitions 1 -vms 2` (takes ~30 seconds) in order to obtain performance measurements. For real examples, higher execution times are needed, but for the demo case, this is sufficient.

Afterwards, run `./peass getchanges -data ../demo-project_peass/clean/ -dependencyfile results/deps_demo-project.json` (takes ~1 second) in order to identify the changes. Now in results/clean.json, all changes are listed. As expected, 9caed514e0759dbfa4ef29acca78787e34d99975 contains a change in the test onlyCallMethod1. 

## Executing the Root Cause Analysis

Execute `./peass searchcause -vms 2 -iterations 1 -warmup 0 -version 9caed514e0759dbfa4ef29acca78787e34d99975 -test de.test.CalleeTest#onlyCallMethod1 -folder ../demo-project -executionfile results/execute_demo-project.json` (takes ~8 minutes) in order to get changes.

To finally get the root cause analysis visualization, run `./peass visualizerca -data ../demo-project_peass/ -propertyFolder results/properties_demo-project/`. Now, results/ contains the file de.test.CalleeTest#onlyCallMethod1.html which you can visualize in your browser. You'll see that CalleeTest#onlyCallMethod1, Callee#method1 and Callee#innerMethod are red - therefore, all this have gotten slower and Callee#innerMethod is very likely the root cause of the performance change.

## Spotting Bugs

In case any step did not work, you can check whether the results (both in `demo-project_peass`, mostly results for potential remote execution, and in `results`, mostly results which are relevant to the developer) look correct. If this does not work, do not hesitate to contact the maintainer. 
