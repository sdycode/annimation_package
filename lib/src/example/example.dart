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
        // timeLinePointerXPosition = getActualStickserPositionFromPercentValue(
        //     newanimationController!.value * 100, context);
      });
    });
    // loadProjectFromAsset();
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
                // AnimationFromAssetFileWithTimeDuration(
                //   filePath: "assets/circlebounce3.json",
                //   size: Size(boxW, boxW),
                // ),
                // AnimationFromAssetFileWithTimeDuration(
                //   filePath: "assets/anim8.json",
                //   size: Size(300, 250),
                // ),
                // AnimationFromAssetFileWithTimeDuration(
                //   filePath: "assets/anim6.json",
                //   size: Size(300, 250),
                // ),
                // AnimationFromAssetFileWithTimeDuration(
                //   filePath: "assets/anim5.json",
                //   size: Size(300, 250),
                // )
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
