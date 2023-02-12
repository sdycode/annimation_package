import 'dart:developer';

// import 'package:annimation/src/models/new_full_user_model.dart';
// import 'package:annimation/src/numeric%20funtions/getPercentValueForStickPosition.dart';
// import 'package:annimation/src/numeric%20funtions/get_index_for_new_frame_for_frameposition.dart';
// import 'package:annimation/src/numeric%20funtions/get_modified_percentvalue_for_preframeno.dart';
// import 'package:annimation/src/shape%20functions/get_interpolated_point.dart';
// import 'package:annimation/src/sizes/drawing_grid_canvas_fields.dart';
// import 'package:annimation/src/sizes/sizes_landscape.dart';
import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/numeric%20funtions/getPercentValueForStickPosition.dart';
import 'package:annimation/src/numeric%20funtions/get_index_for_new_frame_for_frameposition.dart';
import 'package:annimation/src/numeric%20funtions/get_modified_percentvalue_for_preframeno.dart';
import 'package:annimation/src/shape%20functions/get_interpolated_point.dart';
import 'package:flutter/material.dart';

getAnimatedPoints(BuildContext context,
    {int projNo = 0,
    required List<Project> projectList,
    required List<int> iconSectionIndexesToIncludeInAnimationList,
    required double timeLinePointerXPosition,
    required Map<int, List<double>> framePosPercentListForAllIconSections,}) {
  List<List<Point>> allsectionSPoints = [];
  double interValue = 0;
  try {
    interValue =
        getPercentValueForStickPosition(timeLinePointerXPosition, context);
  } catch (e) {
    // showErrorDialog(
    //     context, "Error ininterValue getAnimatedPoints interValue  $e");
  }
  // log("interValue ${interValue.toStringAsFixed(2)} :  projNo  $projNo /${projectList[projNo].iconSections.length} / ${iconSectionIndexesToIncludeInAnimationList}");
  for (int iconNo = 0;
      iconNo < projectList[projNo].iconSections.length;
      iconNo++) {
    // log("iconSectionIndexesToIncludeInAnimationList [$iconNo] : $iconSectionIndexesToIncludeInAnimationList");
    if (!iconSectionIndexesToIncludeInAnimationList.contains(iconNo)) {
      continue;
    }
    // log("iconSectionIndexesToIncludeInAnimationList  [$iconNo] :show ani  ${iconSectionIndexesToIncludeInAnimationList}");
    // log("inin with icon $iconNo and $currntframePosPercentList");
    List<Point> animatedPoints = [];
    int preFrameNo = 0;
    try {
      preFrameNo = getIndexForPreFrameForProgressPercentValue(
          interValue, iconNo, framePosPercentListForAllIconSections);
      // log("preFrameNo after get $preFrameNo");
    } catch (e) {
      log("Error in getAnimatedPoints preFrameNo $preFrameNo:   $e");

      // showErrorDialog(
      //     context, "Error in getAnimatedPoints preFrameNo $preFrameNo:   $e");
    }

    double modifiedPercentValue = get_modified_percentvalue_for_preframeno(
        preFrameNo, interValue, iconNo, framePosPercentListForAllIconSections);
    // log(" $iconNo : preFrameNo $preFrameNo /${projectList[projNo].iconSections[iconNo].frames.length} / for iconno $iconNo :  / ${modifiedPercentValue} :  $interValue and // preframe  stick $timeLinePointerXPosition");
    for (var i = 0;
        i <
            projectList[projNo]
                .iconSections[iconNo]
                .frames[preFrameNo]
                .singleFrameModel
                .points
                .length;
        i++) {
      try {
        if (projectList[projNo].iconSections[iconNo].frames.length >
            preFrameNo + 1) {
          try {
            // log("icon $iconNo :  indexi $i : - ${preFrameNo} - ${preFrameNo + 1} ::: ${projectList[projNo].iconSections[iconNo].frames[preFrameNo].singleFrameModel.points.length} :: ${projectList[projNo].iconSections[iconNo].frames[preFrameNo + 1].singleFrameModel.points.length}  ");
          } catch (e) {
            log("indexi errr $e");
          }
          animatedPoints.add(getInterPolatedPoint(
              modifiedPercentValue,
              projectList[projNo]
                  .iconSections[iconNo]
                  .frames[preFrameNo]
                  .singleFrameModel
                  .points[i],
              projectList[projNo]
                  .iconSections[iconNo]
                  .frames[preFrameNo + 1]
                  .singleFrameModel
                  .points[i]));
        }
      } catch (e) {
        log("Error in getAnimatedPoints   animatedPoints.add(getInterPolatedPoint( @$i $e");
        // showErrorDialog(context,
        //     "Error in getAnimatedPoints   animatedPoints.add(getInterPolatedPoint(  $e");
      }
    }
    allsectionSPoints.add(animatedPoints);
  }

  return allsectionSPoints;
}
