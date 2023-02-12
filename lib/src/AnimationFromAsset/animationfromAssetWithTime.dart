import 'dart:convert';
import 'dart:developer';
import 'dart:math' as m;

import 'package:annimation/src/models/animate_points_model.dart';
import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/models/pair_model.dart';
import 'package:annimation/src/numeric%20funtions/getActualStickserPositionFromPercentValue.dart';
import 'package:annimation/src/numeric%20funtions/update_framePos_list.dart';
import 'package:annimation/src/paint/polyline_paint.dart';
import 'package:annimation/src/sizes/sizes_landscape.dart';
import 'package:annimation/src/utils/get_animatedpoints.dart';
import 'package:annimation/src/utils/points_to_offsets.dart';
import 'package:flutter/material.dart';

enum ClickAnimationDirection { none, forwardOnly, forwardReverse }

class AnimationFromAssetFileWithTimeDuration extends StatefulWidget {
  String filePath;
  Duration animationDuration;
  Size size;
  bool repeat;
  ClickAnimationDirection clickAnimationDirection;  Color? singleColor;

  // bool
  AnimationFromAssetFileWithTimeDuration(
      {Key? key,
      required this.filePath,
      this.animationDuration = const Duration(milliseconds: 2000),
      this.size = const Size(240, 240),
      this.repeat = false,
      this.clickAnimationDirection = ClickAnimationDirection.none,  
      this.singleColor})
      : super(key: key);

//       final
// final
// final
// final
// const

  @override
  State<AnimationFromAssetFileWithTimeDuration> createState() =>
      _AnimationFromAssetFileWithTimeDurationState();
}

class _AnimationFromAssetFileWithTimeDurationState
    extends State<AnimationFromAssetFileWithTimeDuration>
    with TickerProviderStateMixin {
  List<Project> _projectList = [];

  int noOfSidesOfPolygon = 5;
  Point centerPoint = Point.zero;
  double finalAngle = 0.0;
  double oldAngle = 0.0;
  double upsetAngle = 0.0;
  Point startForRotate = Point.zero;
  Point endForRotate = Point.zero;
  double startDistanceForRotate = 0;
  double newDistanceForRotate = 0;
  double scale = 1.0;
  double animTotalTime = 2000;
  List<Point> tempShapeEndPoints = [];
  bool firstTimeDraw = true;
// const List<Color> myColors = [...(Colors.primaries)];
  List<AnimatePointsModel> animatePointsModels = [];
  List<Point> frame1Points = [];
  List<Point> frame2Points = [];
  List<Point> animatingFramePoints = [];
  bool framePointsSetForAnimation = false;
  bool framePointsForMultiSectionsAreSetForAnimation = false;
  bool showAnimationPanel = true;
  int selectedPointIndex = 0;
  int currentProjectNo = 0;
  int oldProjectNo = 0;
  int currentIconSectionNo = 0;
  int currentFrameListNo = 0;
  int currentFrameNo = 0;
  List<Project> projectList = [];
  List<double> currntframePosPercentList = [0, 100];
// List<IconSection> currentIconSectionsList = [currentIconSection];
// IconSection currentIconSection = IconSection(
//     iconSectionNo: currentIconSectionNo,
//     iconSectionName: "Polyline_${currentIconSectionNo}",
//     position: Point.zero,
//     frames: [currentFrame]);
// Frame currentFrame = Frame(
//     frameNo: currentSingleFrameModel.frameNo,
//     singleFrameModel: currentSingleFrameModel);
  String currentProjectName = "AnimatedIconProject";
  TextEditingController userNameController = TextEditingController();
  Offset hoverPoint = Offset.zero;
  // Size biggerSize = Size(200, 200);
  Pair controlPointAdjecntPair = Pair(0, 1);
  Map<int, Offset> controlMidPoints = {};
// List<Offset> points = [];
  int panPointIndex = -1;
  bool close = false;
// Project level fields
  SingleFrameModel currentSingleFrameModel = SingleFrameModel(frameNo: 0);

//  From size landscap file
  double topbarHeight = 40;
  double drawingComponentsTreeBoxWidth = 200;
  double editFeaturesPalleteBoxWidth = 260;
  double borderMargin = 2;
  double textFieldBoxHeight = 40;
  double defaultProjectWidth = 400;
  double defaultProjectHeight = 400;
  // Size drawingBoardSize = Size(300, 300);
  Offset drawingBoardPosition = Offset(50, 50);
  List<int> iconSectionIndexesToIncludeInAnimationList = [];
  double iconSectionBarHeightInAnimationSheet = 34;
  double animaBarH = 10;
  double animSheetHeightFactor = 75;
  double animIconSectionTreeWidthFactor = 20;
  double animSheetMainBoxWidthFactor = 80;
  double animTimelineWidthFactor = 76;
  double timelineBarH = 1;
  double _timeLinePointerXPosition = 0;
  double xSpanForTime = 74;
  double animFrameAddbtnHeight = 4;
  double iconsectionsTreeinAnimSheetScrollPosition = 0;
  Map<int, List<double>> _framePosPercentListForAllIconSections = {
    0: [0, 100]
  };

  late AnimationController newanimationController;
  @override
  void initState() {
    // drawingBoardSize = Size(defaultProjectWidth, defaultProjectHeight);
    // TODO: implement initState
    super.initState();

    newanimationController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    newanimationController.addListener(() {
      setState(() {
        _timeLinePointerXPosition = getActualStickserPositionFromPercentValue(
            newanimationController.value * 100, context);
      });
    });
    loadProjectFromAsset();
  }

  @override
  Widget build(BuildContext context) {
    if (_projectList.isEmpty) {
      return Container(width: widget.size.width, height: widget.size.height);
    }
    List<List<Point>> allsectionSPoints = getAnimatedPoints(context,
        iconSectionIndexesToIncludeInAnimationList:
            iconSectionIndexesToIncludeInAnimationList,
        timeLinePointerXPosition: _timeLinePointerXPosition,
        projectList: _projectList,
        framePosPercentListForAllIconSections:
            _framePosPercentListForAllIconSections);
    List<int> indexes = [];
    for (int iconNo = 0;
        iconNo < _projectList[0].iconSections.length;
        iconNo++) {
      // log("iconSectionIndexesToIncludeInAnimationList [$iconNo] : ${iconSectionIndexesToIncludeInAnimationList}");
      if (!iconSectionIndexesToIncludeInAnimationList.contains(iconNo)) {
        continue;
      }
      indexes.add(iconNo);
    }
    // log("allsectionSPoints ${allsectionSPoints.length} $indexes");
    // log("size is ${_projectList[0].width} ${_projectList[0].height} /// ${widget.size.width.toStringAsFixed(2)} ${widget.size.height.toStringAsFixed(2)}");

    return ClipRect(
      child: GestureDetector(
        onTap: () {
          if (widget.clickAnimationDirection ==
              ClickAnimationDirection.forwardOnly) {
            log("animis ${widget.clickAnimationDirection} ");
            newanimationController.reset();
            newanimationController.forward();
          }
          if (widget.clickAnimationDirection ==
              ClickAnimationDirection.forwardReverse) {
            // log("animis ${widget.clickAnimationDirection} ${newanimationController.status} ");
            if (newanimationController.status == AnimationStatus.dismissed || newanimationController.status ==
                AnimationStatus.reverse) {
              newanimationController.reset();
              newanimationController.forward();
            }else if(newanimationController.status == AnimationStatus.forward || newanimationController.status == AnimationStatus.completed){
               newanimationController.reverse();
            }

            // if (newanimationController.status == AnimationStatus.forward) {
            //   newanimationController.reverse();
            // } else if (newanimationController.status ==
            //     AnimationStatus.reverse) {
            //   newanimationController.reset();
            //   newanimationController.forward();
            // }
          }
        },
        child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: Colors.primaries[m.Random().nextInt(10)].withAlpha(0),
            child: Stack(
                // fit: StackFit.passthrough,
                children: [
                  ...(List.generate(
                    allsectionSPoints.length,
                    (iconIndex) => CustomPaint(
                      size: Size(
                        widget.size.width,
                        widget.size.height,
                      ),
                      painter: PointsLinePaint(
                          pointsToOffsets(allsectionSPoints[iconIndex]),
                          iconsecIndex: iconIndex,
                          indexes: indexes,
                          project: _projectList[0],
                          parentSize: widget.size,
                          singleColor: widget.singleColor
                          ),
                    ),
                  ))
                ])),
      ),
    );
  }

  Future loadProjectFromAsset() async {
    Map<String, dynamic> proj = {};
    try {
      String data =
          await DefaultAssetBundle.of(context).loadString(widget.filePath);

      proj = json.decode(data);

      Project project = Project.fromMap(proj);
      _projectList.clear();
      _projectList.add(project);
      iconSectionIndexesToIncludeInAnimationList.clear();
      for (var i = 0; i < _projectList[0].iconSections.length; i++) {
        iconSectionIndexesToIncludeInAnimationList.add(i);
      }
      updateFramePostListForAllsectionsInProject(_projectList,
          currntframePosPercentList, _framePosPercentListForAllIconSections);
      if (mounted) {
        setState(() {
          if (widget.repeat) {
            newanimationController.repeat();
          } else {
            if (widget.clickAnimationDirection ==
                ClickAnimationDirection.none) {
              newanimationController.forward();
            }
          }
        });
      }
    } catch (e) {}
  }
}
