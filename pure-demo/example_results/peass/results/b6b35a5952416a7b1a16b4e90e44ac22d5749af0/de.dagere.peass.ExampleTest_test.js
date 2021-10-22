if (document.getElementById('testcaseDiv') != null) 
   document.getElementById('testcaseDiv').innerHTML="Version: <a href='javascript:fallbackCopyTextToClipboard(\"-version b6b35a5952416a7b1a16b4e90e44ac22d5749af0 -test de.dagere.peass.ExampleTest#test\")'>b6b35a5952416a7b1a16b4e90e44ac22d5749af0</a><br>Test Case: de.dagere.peass.ExampleTest#test<br><a href='de.dagere.peass.ExampleTest_test_dashboard.html?call=overall&ess=-1' target='parent'>Inspect Overall Measurement</a>";

var source = {"current":
{
 "de.dagere.peass.ExampleClazz.<init>_":
 ``,"de.dagere.peass.ExampleClazz.calleeMethod_":
 `protected void calleeMethod() {
    new Callee().method1();
}`,"de.dagere.peass.Callee.<init>_":
 ``,"de.dagere.peass.Callee.innerMethod_":
 `private void innerMethod() {
    try {
        Thread.sleep(20);
    } catch (final InterruptedException e) {
        e.printStackTrace();
    }
}`,"de.dagere.peass.ExampleTest.test_":
 `@Test
public void test() {
    final ExampleClazz exampleClazz = new ExampleClazz();
    exampleClazz.calleeMethod();
    assertNotNull(exampleClazz);
}`,"de.dagere.peass.Callee.method1_":
 `protected void method1() {
    innerMethod();
}`,},
"old":
{
 "de.dagere.peass.ExampleClazz.<init>_":
 ``,"de.dagere.peass.ExampleClazz.calleeMethod_":
 `protected void calleeMethod() {
    new Callee().method1();
}`,"de.dagere.peass.Callee.<init>_":
 ``,"de.dagere.peass.Callee.innerMethod_":
 `private void innerMethod() {
    try {
        Thread.sleep(1);
    } catch (final InterruptedException e) {
        e.printStackTrace();
    }
}`,"de.dagere.peass.ExampleTest.test_":
 `@Test
public void test() {
    final ExampleClazz exampleClazz = new ExampleClazz();
    exampleClazz.calleeMethod();
    assertNotNull(exampleClazz);
}`,"de.dagere.peass.Callee.method1_":
 `protected void method1() {
    innerMethod();
}`,},
};
var treeData = [
{
  "call" : "de.dagere.peass.ExampleTest#test",
  "kiekerPattern" : "public void de.dagere.peass.ExampleTest.test()",
  "otherKiekerPattern" : "public void de.dagere.peass.ExampleTest.test()",
  "module" : "",
  "name" : "ExampleTest#test",
  "key" : "de.dagere.peass.ExampleTest.test_",
  "otherKey" : "de.dagere.peass.ExampleTest.test_",
  "parent" : null,
  "color" : "#FF0000",
  "statistic" : {
    "meanOld" : 1250.6666666666667,
    "meanCurrent" : 20641.77777777778,
    "deviationOld" : 15.802566598850929,
    "deviationCurrent" : 147.76901770192643,
    "vms" : 3,
    "callsOld" : 435,
    "calls" : 435,
    "tvalue" : -226.0011510796693,
    "change" : true
  },
  "hasSourceChange" : false,
  "state" : "SLOWER",
  "inVMDeviationPredecessor" : 0.0,
  "inVMDeviation" : 0.0,
  "ess" : 0,
  "values" : [ 20594.633333333335, 20523.333333333336, 20807.36666666667 ],
  "valuesPredecessor" : [ 1249.7666666666667, 1266.9, 1235.333333333333 ],
  "vmValues" : {
    "values" : {
      "0" : [ {
        "mean" : 20594.633333333335,
        "variance" : 46644.44712643725,
        "n" : 145,
        "max" : 21579.0,
        "min" : 20412.0,
        "sum" : 2986221.8333333335,
        "standardDeviation" : 215.97325558141972
      } ],
      "1" : [ {
        "mean" : 20523.333333333336,
        "variance" : 158957.81609195418,
        "n" : 145,
        "max" : 22403.0,
        "min" : 20171.0,
        "sum" : 2975883.3333333335,
        "standardDeviation" : 398.69514179627794
      } ],
      "2" : [ {
        "mean" : 20807.36666666667,
        "variance" : 880241.1367816097,
        "n" : 145,
        "max" : 25704.0,
        "min" : 20408.0,
        "sum" : 3017068.166666667,
        "standardDeviation" : 938.2116694976725
      } ]
    }
  },
  "vmValuesPredecessor" : {
    "values" : {
      "0" : [ {
        "mean" : 1249.7666666666667,
        "variance" : 89698.11609195404,
        "n" : 145,
        "max" : 2825.0,
        "min" : 1146.0,
        "sum" : 181216.16666666666,
        "standardDeviation" : 299.4964375279847
      } ],
      "1" : [ {
        "mean" : 1266.9,
        "variance" : 65694.64482758619,
        "n" : 145,
        "max" : 2590.0,
        "min" : 1125.0,
        "sum" : 183700.5,
        "standardDeviation" : 256.30966588793757
      } ],
      "2" : [ {
        "mean" : 1235.333333333333,
        "variance" : 137418.1609195402,
        "n" : 145,
        "max" : 3187.0,
        "min" : 1116.0,
        "sum" : 179123.33333333328,
        "standardDeviation" : 370.6995561361521
      } ]
    }
  },
  "children" : [ {
    "call" : "de.dagere.peass.ExampleClazz#<init>",
    "kiekerPattern" : "public new de.dagere.peass.ExampleClazz.<init>()",
    "otherKiekerPattern" : "public new de.dagere.peass.ExampleClazz.<init>()",
    "module" : "",
    "name" : "ExampleClazz#<init>",
    "key" : "de.dagere.peass.ExampleClazz.<init>_",
    "otherKey" : "de.dagere.peass.ExampleClazz.<init>_",
    "parent" : "de.dagere.peass.ExampleTest#test",
    "color" : null,
    "statistic" : {
      "meanOld" : 0.15555555555555559,
      "meanCurrent" : 0.9888888888888887,
      "deviationOld" : 0.03849001794597505,
      "deviationCurrent" : 0.6500712211693364,
      "vms" : 3,
      "callsOld" : 435,
      "calls" : 435,
      "tvalue" : -2.216452967120782
    },
    "hasSourceChange" : false,
    "state" : null,
    "inVMDeviationPredecessor" : 0.0,
    "inVMDeviation" : 0.0,
    "ess" : 1,
    "values" : [ 0.7, 0.5333333333333333, 1.733333333333333 ],
    "valuesPredecessor" : [ 0.2, 0.13333333333333333, 0.1333333333333334 ],
    "vmValues" : {
      "values" : {
        "0" : [ {
          "mean" : 0.7,
          "variance" : 0.7689655172413792,
          "n" : 145,
          "max" : 3.0,
          "min" : 0.0,
          "sum" : 101.5,
          "standardDeviation" : 0.8769067893689609
        } ],
        "1" : [ {
          "mean" : 0.5333333333333333,
          "variance" : 0.671264367816092,
          "n" : 145,
          "max" : 2.0,
          "min" : 0.0,
          "sum" : 77.33333333333333,
          "standardDeviation" : 0.8193072487266861
        } ],
        "2" : [ {
          "mean" : 1.733333333333333,
          "variance" : 2.3402298850574708,
          "n" : 145,
          "max" : 7.0,
          "min" : 0.0,
          "sum" : 251.3333333333333,
          "standardDeviation" : 1.529780992514115
        } ]
      }
    },
    "vmValuesPredecessor" : {
      "values" : {
        "0" : [ {
          "mean" : 0.2,
          "variance" : 0.23448275862068968,
          "n" : 145,
          "max" : 2.0,
          "min" : 0.0,
          "sum" : 29.0,
          "standardDeviation" : 0.4842341981115023
        } ],
        "1" : [ {
          "mean" : 0.13333333333333333,
          "variance" : 0.18850574712643675,
          "n" : 145,
          "max" : 2.0,
          "min" : 0.0,
          "sum" : 19.333333333333332,
          "standardDeviation" : 0.4341724854553047
        } ],
        "2" : [ {
          "mean" : 0.1333333333333334,
          "variance" : 0.18850574712643675,
          "n" : 145,
          "max" : 2.0,
          "min" : 0.0,
          "sum" : 19.333333333333343,
          "standardDeviation" : 0.4341724854553047
        } ]
      }
    },
    "children" : [ ]
  }, {
    "call" : "de.dagere.peass.ExampleClazz#calleeMethod",
    "kiekerPattern" : "protected void de.dagere.peass.ExampleClazz.calleeMethod()",
    "otherKiekerPattern" : "protected void de.dagere.peass.ExampleClazz.calleeMethod()",
    "module" : "",
    "name" : "ExampleClazz#calleeMethod",
    "key" : "de.dagere.peass.ExampleClazz.calleeMethod_",
    "otherKey" : "de.dagere.peass.ExampleClazz.calleeMethod_",
    "parent" : "de.dagere.peass.ExampleTest#test",
    "color" : "#FF0000",
    "statistic" : {
      "meanOld" : 1178.311111111111,
      "meanCurrent" : 20469.48888888889,
      "deviationOld" : 16.171900641865548,
      "deviationCurrent" : 85.92152966084316,
      "vms" : 3,
      "callsOld" : 435,
      "calls" : 435,
      "tvalue" : -382.1711557192131,
      "change" : true
    },
    "hasSourceChange" : false,
    "state" : "SLOWER",
    "inVMDeviationPredecessor" : 0.0,
    "inVMDeviation" : 0.0,
    "ess" : 1,
    "values" : [ 20468.433333333334, 20384.1, 20555.93333333333 ],
    "valuesPredecessor" : [ 1179.5999999999997, 1193.8000000000002, 1161.5333333333333 ],
    "vmValues" : {
      "values" : {
        "0" : [ {
          "mean" : 20468.433333333334,
          "variance" : 10276.943678160897,
          "n" : 145,
          "max" : 20729.0,
          "min" : 20335.0,
          "sum" : 2967922.8333333335,
          "standardDeviation" : 101.37526166753355
        } ],
        "1" : [ {
          "mean" : 20384.1,
          "variance" : 33498.57586206872,
          "n" : 145,
          "max" : 21009.0,
          "min" : 20138.0,
          "sum" : 2955694.5,
          "standardDeviation" : 183.02616168752684
        } ],
        "2" : [ {
          "mean" : 20555.93333333333,
          "variance" : 126911.44367816066,
          "n" : 145,
          "max" : 22369.0,
          "min" : 20351.0,
          "sum" : 2980610.333333333,
          "standardDeviation" : 356.24632444161534
        } ]
      }
    },
    "vmValuesPredecessor" : {
      "values" : {
        "0" : [ {
          "mean" : 1179.5999999999997,
          "variance" : 15085.075862068961,
          "n" : 145,
          "max" : 1803.0,
          "min" : 1117.0,
          "sum" : 171041.99999999994,
          "standardDeviation" : 122.82131680644432
        } ],
        "1" : [ {
          "mean" : 1193.8000000000002,
          "variance" : 10269.2,
          "n" : 145,
          "max" : 1659.0,
          "min" : 1102.0,
          "sum" : 173101.00000000003,
          "standardDeviation" : 101.33706133493314
        } ],
        "2" : [ {
          "mean" : 1161.5333333333333,
          "variance" : 20922.53333333332,
          "n" : 145,
          "max" : 1912.0,
          "min" : 1099.0,
          "sum" : 168422.33333333334,
          "standardDeviation" : 144.64623511634625
        } ]
      }
    },
    "children" : [ {
      "call" : "de.dagere.peass.Callee#<init>",
      "kiekerPattern" : "public new de.dagere.peass.Callee.<init>()",
      "otherKiekerPattern" : "public new de.dagere.peass.Callee.<init>()",
      "module" : "",
      "name" : "Callee#<init>",
      "key" : "de.dagere.peass.Callee.<init>_",
      "otherKey" : "de.dagere.peass.Callee.<init>_",
      "parent" : "de.dagere.peass.ExampleClazz#calleeMethod",
      "color" : null,
      "statistic" : {
        "meanOld" : 0.07777777777777779,
        "meanCurrent" : 0.8333333333333333,
        "deviationOld" : 0.05091750772173158,
        "deviationCurrent" : 0.5773502691896257,
        "vms" : 3,
        "callsOld" : 435,
        "calls" : 435,
        "tvalue" : -2.2579029405811255
      },
      "hasSourceChange" : false,
      "state" : null,
      "inVMDeviationPredecessor" : 0.0,
      "inVMDeviation" : 0.0,
      "ess" : 2,
      "values" : [ 0.5, 0.49999999999999983, 1.5 ],
      "valuesPredecessor" : [ 0.03333333333333335, 0.06666666666666667, 0.1333333333333334 ],
      "vmValues" : {
        "values" : {
          "0" : [ {
            "mean" : 0.5,
            "variance" : 0.396551724137931,
            "n" : 145,
            "max" : 2.0,
            "min" : 0.0,
            "sum" : 72.5,
            "standardDeviation" : 0.6297235299224025
          } ],
          "1" : [ {
            "mean" : 0.49999999999999983,
            "variance" : 0.672413793103448,
            "n" : 145,
            "max" : 3.0,
            "min" : 0.0,
            "sum" : 72.49999999999997,
            "standardDeviation" : 0.8200084103858009
          } ],
          "2" : [ {
            "mean" : 1.5,
            "variance" : 1.8448275862068968,
            "n" : 145,
            "max" : 5.0,
            "min" : 0.0,
            "sum" : 217.5,
            "standardDeviation" : 1.3582443028435263
          } ]
        }
      },
      "vmValuesPredecessor" : {
        "values" : {
          "0" : [ {
            "mean" : 0.03333333333333335,
            "variance" : 0.033333333333333326,
            "n" : 145,
            "max" : 1.0,
            "min" : 0.0,
            "sum" : 4.833333333333336,
            "standardDeviation" : 0.18257418583505536
          } ],
          "1" : [ {
            "mean" : 0.06666666666666667,
            "variance" : 0.06436781609195402,
            "n" : 145,
            "max" : 1.0,
            "min" : 0.0,
            "sum" : 9.666666666666666,
            "standardDeviation" : 0.2537081317024624
          } ],
          "2" : [ {
            "mean" : 0.1333333333333334,
            "variance" : 0.18850574712643675,
            "n" : 145,
            "max" : 2.0,
            "min" : 0.0,
            "sum" : 19.333333333333343,
            "standardDeviation" : 0.4341724854553047
          } ]
        }
      },
      "children" : [ ]
    }, {
      "call" : "de.dagere.peass.Callee#method1",
      "kiekerPattern" : "protected void de.dagere.peass.Callee.method1()",
      "otherKiekerPattern" : "protected void de.dagere.peass.Callee.method1()",
      "module" : "",
      "name" : "Callee#method1",
      "key" : "de.dagere.peass.Callee.method1_",
      "otherKey" : "de.dagere.peass.Callee.method1_",
      "parent" : "de.dagere.peass.ExampleClazz#calleeMethod",
      "color" : "#FF0000",
      "statistic" : {
        "meanOld" : 1125.7555555555552,
        "meanCurrent" : 20333.222222222223,
        "deviationOld" : 14.122178512040133,
        "deviationCurrent" : 43.69777941641545,
        "vms" : 3,
        "callsOld" : 435,
        "calls" : 435,
        "tvalue" : -724.435030049953,
        "change" : true
      },
      "hasSourceChange" : false,
      "state" : "SLOWER",
      "inVMDeviationPredecessor" : 0.0,
      "inVMDeviation" : 0.0,
      "ess" : 2,
      "values" : [ 20358.86666666667, 20282.76666666667, 20358.03333333333 ],
      "valuesPredecessor" : [ 1127.2, 1139.0999999999997, 1110.9666666666662 ],
      "vmValues" : {
        "values" : {
          "0" : [ {
            "mean" : 20358.86666666667,
            "variance" : 4924.188505747115,
            "n" : 145,
            "max" : 20464.0,
            "min" : 20163.0,
            "sum" : 2952035.666666667,
            "standardDeviation" : 70.17256234274986
          } ],
          "1" : [ {
            "mean" : 20282.76666666667,
            "variance" : 11066.529885057746,
            "n" : 145,
            "max" : 20447.0,
            "min" : 20099.0,
            "sum" : 2941001.166666667,
            "standardDeviation" : 105.19757547138501
          } ],
          "2" : [ {
            "mean" : 20358.03333333333,
            "variance" : 5117.274712643562,
            "n" : 145,
            "max" : 20560.0,
            "min" : 20238.0,
            "sum" : 2951914.8333333326,
            "standardDeviation" : 71.53512922084899
          } ]
        }
      },
      "vmValuesPredecessor" : {
        "values" : {
          "0" : [ {
            "mean" : 1127.2,
            "variance" : 1354.3034482758617,
            "n" : 145,
            "max" : 1236.0,
            "min" : 1091.0,
            "sum" : 163444.0,
            "standardDeviation" : 36.800862058868425
          } ],
          "1" : [ {
            "mean" : 1139.0999999999997,
            "variance" : 2359.9551724138064,
            "n" : 145,
            "max" : 1265.0,
            "min" : 1082.0,
            "sum" : 165169.49999999994,
            "standardDeviation" : 48.57936982314413
          } ],
          "2" : [ {
            "mean" : 1110.9666666666662,
            "variance" : 842.1712643678198,
            "n" : 145,
            "max" : 1203.0,
            "min" : 1078.0,
            "sum" : 161090.1666666666,
            "standardDeviation" : 29.020187186987954
          } ]
        }
      },
      "children" : [ {
        "call" : "de.dagere.peass.Callee#innerMethod",
        "kiekerPattern" : "private void de.dagere.peass.Callee.innerMethod()",
        "otherKiekerPattern" : "private void de.dagere.peass.Callee.innerMethod()",
        "module" : "",
        "name" : "Callee#innerMethod",
        "key" : "de.dagere.peass.Callee.innerMethod_",
        "otherKey" : "de.dagere.peass.Callee.innerMethod_",
        "parent" : "de.dagere.peass.Callee#method1",
        "color" : "#FF0000",
        "statistic" : {
          "meanOld" : 1077.1000000000001,
          "meanCurrent" : 20143.71111111111,
          "deviationOld" : 8.251868475280734,
          "deviationCurrent" : 14.991861989955849,
          "vms" : 3,
          "callsOld" : 435,
          "calls" : 435,
          "tvalue" : -1929.7989736059067,
          "change" : true
        },
        "hasSourceChange" : true,
        "state" : "SLOWER",
        "inVMDeviationPredecessor" : 0.0,
        "inVMDeviation" : 0.0,
        "ess" : 3,
        "values" : [ 20160.566666666666, 20131.86666666667, 20138.7 ],
        "valuesPredecessor" : [ 1076.0333333333335, 1085.8333333333333, 1069.4333333333334 ],
        "vmValues" : {
          "values" : {
            "0" : [ {
              "mean" : 20160.566666666666,
              "variance" : 798.1160919540173,
              "n" : 145,
              "max" : 20191.0,
              "min" : 20083.0,
              "sum" : 2923282.1666666665,
              "standardDeviation" : 28.25094851423607
            } ],
            "1" : [ {
              "mean" : 20131.86666666667,
              "variance" : 1769.8436781609344,
              "n" : 145,
              "max" : 20194.0,
              "min" : 20065.0,
              "sum" : 2919120.666666667,
              "standardDeviation" : 42.069510077500716
            } ],
            "2" : [ {
              "mean" : 20138.7,
              "variance" : 291.3206896551765,
              "n" : 145,
              "max" : 20178.0,
              "min" : 20103.0,
              "sum" : 2920111.5,
              "standardDeviation" : 17.068119101271133
            } ]
          }
        },
        "vmValuesPredecessor" : {
          "values" : {
            "0" : [ {
              "mean" : 1076.0333333333335,
              "variance" : 152.79195402298794,
              "n" : 145,
              "max" : 1124.0,
              "min" : 1067.0,
              "sum" : 156024.83333333337,
              "standardDeviation" : 12.360904255878205
            } ],
            "1" : [ {
              "mean" : 1085.8333333333333,
              "variance" : 604.3505747126497,
              "n" : 145,
              "max" : 1159.0,
              "min" : 1051.0,
              "sum" : 157445.8333333333,
              "standardDeviation" : 24.583542761625097
            } ],
            "2" : [ {
              "mean" : 1069.4333333333334,
              "variance" : 157.08160919540242,
              "n" : 145,
              "max" : 1119.0,
              "min" : 1031.0,
              "sum" : 155067.83333333334,
              "standardDeviation" : 12.533220224483507
            } ]
          }
        },
        "children" : [ ]
      } ]
    } ]
  } ]
}];
// ************** Generate the tree diagram   *****************
var margin = {top: 20, right: 120, bottom: 20, left: 160},
   width = 1500- margin.right - margin.left,
   height = 175 - margin.top - margin.bottom;
var kopemeData = [
{
  "call" : "overall",
  "kiekerPattern" : "public overall.overall()",
  "otherKiekerPattern" : "public overall.overall()",
  "module" : null,
  "name" : null,
  "key" : "overall.overall_",
  "otherKey" : "overall.overall_",
  "parent" : null,
  "color" : null,
  "statistic" : {
    "meanOld" : 1265.81656,
    "meanCurrent" : 20771.12972,
    "deviationOld" : 47.454781922213016,
    "deviationCurrent" : 101.56599464505172,
    "vms" : 3,
    "callsOld" : 15,
    "calls" : 15,
    "tvalue" : -301.36113904120924
  },
  "hasSourceChange" : false,
  "state" : null,
  "inVMDeviationPredecessor" : 0.0,
  "inVMDeviation" : 0.0,
  "ess" : 0,
  "values" : [ 20767.440119999996, 20671.4588, 20874.490240000003 ],
  "valuesPredecessor" : [ 1314.2523999999999, 1263.78948, 1219.4078 ],
  "vmValues" : {
    "values" : {
      "0" : [ {
        "mean" : 20658.110399999998,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20658.110399999998,
        "min" : 20658.110399999998,
        "sum" : 103290.552,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20892.9666,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20892.9666,
        "min" : 20892.9666,
        "sum" : 104464.833,
        "standardDeviation" : 0.0
      }, {
        "mean" : 21006.7572,
        "variance" : 0.0,
        "n" : 5,
        "max" : 21006.7572,
        "min" : 21006.7572,
        "sum" : 105033.786,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20650.9394,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20650.9394,
        "min" : 20650.9394,
        "sum" : 103254.697,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20628.427,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20628.427,
        "min" : 20628.427,
        "sum" : 103142.135,
        "standardDeviation" : 0.0
      } ],
      "1" : [ {
        "mean" : 20771.614,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20771.614,
        "min" : 20771.614,
        "sum" : 103858.07,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20808.5418,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20808.5418,
        "min" : 20808.5418,
        "sum" : 104042.709,
        "standardDeviation" : 0.0
      }, {
        "mean" : 21035.2478,
        "variance" : 0.0,
        "n" : 5,
        "max" : 21035.2478,
        "min" : 21035.2478,
        "sum" : 105176.239,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20381.4356,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20381.4356,
        "min" : 20381.4356,
        "sum" : 101907.178,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20360.4548,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20360.4548,
        "min" : 20360.4548,
        "sum" : 101802.274,
        "standardDeviation" : 0.0
      } ],
      "2" : [ {
        "mean" : 21114.235800000002,
        "variance" : 0.0,
        "n" : 5,
        "max" : 21114.235800000002,
        "min" : 21114.235800000002,
        "sum" : 105571.179,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20871.8568,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20871.8568,
        "min" : 20871.8568,
        "sum" : 104359.28400000001,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20987.5694,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20987.5694,
        "min" : 20987.5694,
        "sum" : 104937.84700000001,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20754.4906,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20754.4906,
        "min" : 20754.4906,
        "sum" : 103772.45300000001,
        "standardDeviation" : 0.0
      }, {
        "mean" : 20644.298600000002,
        "variance" : 0.0,
        "n" : 5,
        "max" : 20644.298600000002,
        "min" : 20644.298600000002,
        "sum" : 103221.49300000002,
        "standardDeviation" : 0.0
      } ]
    }
  },
  "vmValuesPredecessor" : {
    "values" : {
      "0" : [ {
        "mean" : 1250.1566,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1250.1566,
        "min" : 1250.1566,
        "sum" : 6250.783,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1220.9728,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1220.9728,
        "min" : 1220.9728,
        "sum" : 6104.864,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1360.6581999999999,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1360.6581999999999,
        "min" : 1360.6581999999999,
        "sum" : 6803.290999999999,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1234.2033999999999,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1234.2033999999999,
        "min" : 1234.2033999999999,
        "sum" : 6171.017,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1252.9563999999998,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1252.9563999999998,
        "min" : 1252.9563999999998,
        "sum" : 6264.781999999999,
        "standardDeviation" : 0.0
      } ],
      "1" : [ {
        "mean" : 1271.1066,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1271.1066,
        "min" : 1271.1066,
        "sum" : 6355.533,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1276.4558,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1276.4558,
        "min" : 1276.4558,
        "sum" : 6382.2789999999995,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1303.889,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1303.889,
        "min" : 1303.889,
        "sum" : 6519.445,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1420.3956,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1420.3956,
        "min" : 1420.3956,
        "sum" : 7101.978,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1299.415,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1299.415,
        "min" : 1299.415,
        "sum" : 6497.075,
        "standardDeviation" : 0.0
      } ],
      "2" : [ {
        "mean" : 1242.919,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1242.919,
        "min" : 1242.919,
        "sum" : 6214.595,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1185.724,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1185.724,
        "min" : 1185.724,
        "sum" : 5928.62,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1261.988,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1261.988,
        "min" : 1261.988,
        "sum" : 6309.9400000000005,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1158.0928000000001,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1158.0928000000001,
        "min" : 1158.0928000000001,
        "sum" : 5790.464000000001,
        "standardDeviation" : 0.0
      }, {
        "mean" : 1248.3152,
        "variance" : 0.0,
        "n" : 5,
        "max" : 1248.3152,
        "min" : 1248.3152,
        "sum" : 6241.576,
        "standardDeviation" : 0.0
      } ]
    }
  },
  "children" : [ ]
}];
