# Peass Demo

This demo repo shows how to detect a simple performance change and its cause by [Peass](https://github.com/DaGeRe/peass). It contains several demos (pure-demo, spring-boot-demo, android-demo) which show and check the usability of Peass for these type of projects.

The `pure-demo` contains three versions, where `ExampleTest` creates an instance of `ExampleClazz` and calls its method `calleeMethod`. This method calls `Callee.method1` which calls `Callee.innerMethod` which contains a `Thread.sleep`. In the 3rd version b6b35a5, `Callee.innerMethod` contains a longer call to `Thread.sleep` than before. Therefore, performance gets worse in this version.

If you just want to see the results, you can also immediately open `pure-demo/example_results/peass/results/b6b35a5952416a7b1a16b4e90e44ac22d5749af0/de.dagere.peass.ExampleTest_test.html`.

## Prerequisites

In current development state, it is recommended to use the latest development version of Peass. The following commands require (at least) installed OpenJDK 8, maven and tar and have been tried on Ubuntu 18.04 and 20.04.

For installing the latest development version of Peass run `git clone https://github.com/DaGeRe/peass.git && cd peass && mvn clean install -DskipTests -P buildStarter` inside the root folder of the project in order to clone and build Peass (optionally add `-DskipTests` to the `mvn`-call to speed up building).

To get the example running, untar the example project using `tar -xvf demo-project.tar.xz` (which is a git project itself and is therefore managed inside this repo as tar). For the following commands, we assume that you are in the peass-folder and that the `pure-demo` is in the folder one level above.

So you should got:

* peass (in the main folder)
* pure-demo/demo-project
* pure-demo/demo-project.tar.xz

and than run `cd peass`.

## Executing the Regression Test Selection

Run `./peass select -folder ../pure-demo/demo-project` (takes ~1 minute). After the selection, you'll find `results/execute_demo-project.json`, an executionfile for the project, which specifies which tests could have changed performance based on source code analysis.

## Executing the Measurement and Getting the Changes

Run `./peass measure -executionfile results/execute_demo-project.json -folder ../pure-demo/demo-project -vms 5 -iterations 5 -warmup 5 -repetitions 5` in order to obtain performance measurements. For real examples, higher execution times are needed, but for the demo case, this is sufficient.

Afterwards, run `./peass getchanges -data ../pure-demo/demo-project_peass/ -dependencyfile results/deps_demo-project.json` (takes ~1 second) in order to identify the changes.

Now in `results/changes_demo-project.json`, all changes are listed. As expected, b6b35a5952416a7b1a16b4e90e44ac22d5749af0 contains a change in `ExampleTest.test`.

## Executing the Root Cause Analysis

Execute `./peass searchcause -vms 3 -iterations 5 -warmup 1 -repetitions 5 -version b6b35a5952416a7b1a16b4e90e44ac22d5749af0 -test de.dagere.peass.ExampleTest\#test -folder ../pure-demo/demo-project -executionfile results/execute_demo-project.json` (takes some time) in order to get changes.

To finally get the root cause analysis visualization, run `./peass visualizerca -data ../pure-demo/demo-project_peass/ -propertyFolder results/properties_demo-project/`. 

Now, `results/b6b35a5952416a7b1a16b4e90e44ac22d5749af0` contains the file `de.dagere.peass.ExampleTest_test.html` which you can visualize in your browser. You'll see that *ExampleTest#test*, *ExampleClazz#calleeMethod*, *Callee#method1* and *Callee#innerMethod* are red - therefore, all these have gotten slower and *Callee#innerMethod* is very likely the root cause of the performance change.

## Use the provided shell-script
Instead of running each above step on its own, you can also run `executeAll.sh`. This will execute the described steps and also test some of the results for correctness.

## Spotting Bugs

In case any step did not work, you can check whether the results (both in `pure-demo_peass`, mostly results for potential remote execution and debugging, and in `peass/results`, mostly results which are relevant to the developer) look correct. If this does not work, do not hesitate to contact the maintainer.
