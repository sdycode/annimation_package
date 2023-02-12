TODO: This package is to create animation using web app (Annnimation) (https://sdycode.github.io/Annimation/#/)
## Features

TODO: Just create your custom animation using (Annimation Web App link given above) and export it as json file and import this annimation package and use as given in example below

## Getting started
<h1>Annimation</h1>

TODO:  Just create your custom animation using (Annimation Web App link given above) and export it as json file and import this annimation package and use as given in example below
## Usage

TODO: it contains sample example whose image is given below.

```dart
import 'package:annimation/annimation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnnimationExample(),
    );
  }
}

class AnnimationExample extends StatefulWidget {
  const AnnimationExample({Key? key}) : super(key: key);

  @override
  State<AnnimationExample> createState() => _AnnimationExampleState();
}

class _AnnimationExampleState extends State<AnnimationExample>
    with TickerProviderStateMixin {
  AnimationController? newanimationController;
  Map<String, dynamic> proj = {};
  AnimationData? animationData;
  @override
  void dispose() {
    newanimationController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

    newanimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    newanimationController!.addListener(() {
      setState(() {
       
      });
    });
  
  }

  StateSetter state = (fn) {};
  @override
  Widget build(BuildContext context) {
    double boxW = MediaQuery.of(context).size.width * 0.5;
    return SafeArea(
      child: Scaffold(
        body: StatefulBuilder(
            builder: (BuildContext context, StateSetter _state) {
          state = _state;
          return SingleChildScrollView(
            child: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    if (newanimationController!.status ==
                        AnimationStatus.completed) {
                      newanimationController!.reverse();
                    } else {
                      newanimationController!.reset();
                      newanimationController?.forward();
                    }
                  },
                  child:
                      (animationData != null && newanimationController != null)
                          ? Container(
                              // width: 500,
                              // height: 500,
                              child:
                                  AnimationFromAssetAnimationDataFileWithAnimationController(
                                animationController: newanimationController!,
                                animationData: animationData!,
                                parentSize: Size(boxW, boxW),
                              ),
                            )
                          : FlutterLogo(),
                ),

                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/circlebounce3.json",
                  animationDuration: Duration(milliseconds: 2000),
                  size: Size(boxW, boxW),
                  clickAnimationDirection:
                      ClickAnimationDirection.forwardReverse,
                ),
                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/anim.json",
                  repeat: true,
                  animationDuration: Duration(milliseconds: 2000),
                  size: Size(boxW, boxW),
                  clickAnimationDirection:
                      ClickAnimationDirection.forwardReverse,
                ),

                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/PlayPause.json",
                  animationDuration: Duration(milliseconds: 400),
                  size: Size(boxW, boxW),
                  // repeat: true,
                  singleColor: Colors.green,
                  clickAnimationDirection:
                      ClickAnimationDirection.forwardReverse,
                ),

                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/MultiPolygon.json",
                  animationDuration: Duration(milliseconds: 2000),
                  size: Size(boxW, boxW),
                  repeat: true,
                  clickAnimationDirection:
                      ClickAnimationDirection.forwardReverse,
                ),
                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/HomeMenu.json",
                  animationDuration: Duration(milliseconds: 800),
                  size: Size(boxW, boxW),


                  repeat: true,
                  clickAnimationDirection:
                      ClickAnimationDirection.forwardReverse,
                ),
                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/PlayPause1.json",
                  animationDuration: Duration(milliseconds: 1500),
                  size: Size(boxW, boxW),
                  repeat: true,
                  clickAnimationDirection:
                      ClickAnimationDirection.forwardReverse,
                ),

                AnimationFromAssetFileWithTimeDuration(
                  filePath: "assets/circlebounce2.json",
                  size: Size(boxW, boxW),
                  repeat: true,
                ),
                
              ],
            ),
          );
        }),
      ),
    );
    //           ),
    // );
  }

  void loadData() async {
    try {
      animationData = await AnimationData.loadAnimationDataFromAsset(
          "assets/Segments.json");
    } catch (e) {}

    if (animationData != null) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}

```


https://user-images.githubusercontent.com/63334441/218315648-f00347e0-4fb5-4035-a253-b0e57b07cd40.mp4



## Additional information

TODO: This package contains widgets, classes, functions which gives way to make drawing using polylines, points and show with custom painter and show animation using animation controller
