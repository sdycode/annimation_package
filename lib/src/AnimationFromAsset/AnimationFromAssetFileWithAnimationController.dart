import 'dart:convert';
import 'dart:developer';

import 'package:annimation/src/models/animate_points_model.dart';
import 'package:annimation/src/models/animationDataModel.dart';
import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/models/pair_model.dart';
import 'package:annimation/src/numeric%20funtions/getActualStickserPositionFromPercentValue.dart';
import 'package:annimation/src/numeric%20funtions/update_framePos_list.dart';
import 'package:annimation/src/paint/polyline_paint.dart';
import 'package:annimation/src/utils/get_animatedpoints.dart';
import 'package:annimation/src/utils/points_to_offsets.dart';
import 'package:flutter/material.dart';

class AnimationFromAssetAnimationDataFileWithAnimationController
    extends StatefulWidget {
  AnimationData animationData;
  AnimationController? animationController;
  Size parentSize;
  Color? singleColor;
  AnimationFromAssetAnimationDataFileWithAnimationController(
      {Key? key,
      required this.animationData,
      required this.animationController,
      this.parentSize = const Size(200, 200),
      this.singleColor
      })
      : super(key: key);

  @override
  State<AnimationFromAssetAnimationDataFileWithAnimationController>
      createState() =>
          _AnimationFromAssetAnimationDataFileWithAnimationControllerState();
}

class _AnimationFromAssetAnimationDataFileWithAnimationControllerState
    extends State<AnimationFromAssetAnimationDataFileWithAnimationController>
    with TickerProviderStateMixin {
  final List<Project> _projectList = [];

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

  String currentProjectName = "AnimatedIconProject";
  TextEditingController userNameController = TextEditingController();
  Offset hoverPoint = Offset.zero;
  Size biggerSize = Size(200, 200);
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
  Size drawingBoardSize = Size(300, 300);
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
  List<double> currntframePosPercentList = [0, 100];

  // late AnimationController newanimationController;
  @override
  void initState() {
    // log("AnimationFromAssetAnimationDataFileWithAnimationController init called");
    drawingBoardSize = Size(defaultProjectWidth, defaultProjectHeight);
    // TODO: implement initState
    super.initState();
    _projectList.clear();
    _projectList.add(widget.animationData.project);
    iconSectionIndexesToIncludeInAnimationList =
        widget.animationData.iconSectionIndexesToIncludeInAnimationList;
    currntframePosPercentList = widget.animationData.currntframePosPercentList;
    _framePosPercentListForAllIconSections =
        widget.animationData.framePosPercentListForAllIconSections;
  }

  @override
  Widget build(BuildContext context) {
    // log("AnimationFromAssetAnimationDataFileWithAnimationController build called ${_projectList.length}");

    iconSectionIndexesToIncludeInAnimationList =
        widget.animationData.iconSectionIndexesToIncludeInAnimationList;
    currntframePosPercentList = widget.animationData.currntframePosPercentList;
    _framePosPercentListForAllIconSections =
        widget.animationData.framePosPercentListForAllIconSections;
    _timeLinePointerXPosition = getActualStickserPositionFromPercentValue(
        widget.animationController!.value * 100, context);
    if (_projectList.isEmpty) {
      return Scaffold(body: Text(_projectList.length.toString()));
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

    return Container(
        width: widget.parentSize.width,
        height: widget.parentSize.height,
        color: Colors.orange.shade200,
        child: Stack(children: [
          ...(List.generate(
            allsectionSPoints.length,
            (iconIndex) => CustomPaint(
              size: widget.parentSize,
              painter: PointsLinePaint(
                  pointsToOffsets(allsectionSPoints[iconIndex]),
                  iconsecIndex: iconIndex,
                  indexes: indexes,
                  project: _projectList[0],
                  parentSize: widget.parentSize,
                  singleColor: widget.singleColor
                  ),
            ),
          ))
        ]));
  }
}
