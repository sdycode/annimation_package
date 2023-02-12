import 'dart:developer';

import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/sizes/sizes_landscape.dart';

int get_index_for_new_frame_for_frameposition(
    List<Frame> frames, double curntFrmPos) {
  for (int i = frames.length - 1; i > -1; i--) {
    if (curntFrmPos > frames[i].singleFrameModel.framePosition) {
      return i + 1;
    }
  }
  return 1;
}

int getIndexForPreFrameForProgressPercentValue(
    double progressValue, int iconSecNo,Map<int, List<double>> framePosPercentListForAllIconSections
    
    ) {
  // log("framePosPercentListForAllIconSections ${framePosPercentListForAllIconSections.keys} : :  $iconSecNo : ${framePosPercentListForAllIconSections.length} : $progressValue :  ${framePosPercentListForAllIconSections}");
  if (!framePosPercentListForAllIconSections.containsKey(iconSecNo)) {
    return 0;
  }
  if (framePosPercentListForAllIconSections[iconSecNo]!.isEmpty) {
    return 0;
  }
  for (int i = framePosPercentListForAllIconSections[iconSecNo]!.length - 1;
      i > -1;
      i--) {
    if (i > -1 &&
        i < framePosPercentListForAllIconSections[iconSecNo]!.length) {
      // log("inin $i and $framePosPercentListForAllIconSections[iconSecNo]!");
      if (progressValue >
          framePosPercentListForAllIconSections[iconSecNo]![i]) {
        return i;
      }
    }
  }
  if (currntframePosPercentList.isEmpty) {
    return 0;
  }
  for (int i = currntframePosPercentList.length - 1; i > -1; i--) {
    if (i > -1 && i < currntframePosPercentList.length) {
      // log("inin $i and $currntframePosPercentList");
      if (progressValue > currntframePosPercentList[i]) {
        return i;
      }
    }
  }
  return 0;
}
