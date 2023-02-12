import 'package:flutter/material.dart';

const double topbarHeight = 40;
const double drawingComponentsTreeBoxWidth = 200;
 double editFeaturesPalleteBoxWidth = 260;
const double borderMargin = 2;
const double textFieldBoxHeight = 40;
const double defaultProjectWidth = 400;
const double defaultProjectHeight = 400;
// Size drawingBoardSize = Size(defaultProjectWidth, defaultProjectHeight);
Offset drawingBoardPosition = Offset(50, 50);
List<int> iconSectionIndexesToIncludeInAnimationList = [];
double iconSectionBarHeightInAnimationSheet = 34;
double animaBarH = 10;
double animSheetHeightFactor = 75;
double animIconSectionTreeWidthFactor = 20;
double animSheetMainBoxWidthFactor = 80;
double animTimelineWidthFactor = 76;
double timelineBarH = 1;
double timeLinePointerXPosition = 0;
double xSpanForTime = 74;
double animFrameAddbtnHeight = 4;
double iconsectionsTreeinAnimSheetScrollPosition = 0;
Map<int, List<double>> framePosPercentListForAllIconSections = {
  0: [0, 100]
};
List<double> currntframePosPercentList = [0, 100];
