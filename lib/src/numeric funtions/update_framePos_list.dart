import 'dart:developer';
import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/sizes/drawing_grid_canvas_fields.dart';
import 'package:annimation/src/sizes/sizes_landscape.dart';

void updateFramePostList(int currentIconSectionNo, [int projectNo =0]) {
  currntframePosPercentList.clear();


  projectList[projectNo]
      .iconSections[currentIconSectionNo]
      .frames
      .forEach((e) {
    // log("fore ${e.frameNo}");
    currntframePosPercentList.add(e.singleFrameModel.framePosition);
  });

  List<double> templist = List.from(currntframePosPercentList);
  // log("fore ${templist}");
  templist.sort();
  currntframePosPercentList = List.from(templist);
  // log("foreafte ${templist}");
  framePosPercentListForAllIconSections[currentIconSectionNo] =
      List.from(templist);
}

updateFramePostListForAllsectionsInProject(List<Project>projectList,List<double> currntframePosPercentList,  Map<int, List<double>> framePosPercentListForAllIconSections, [int projectNo =0] ){
  for (var i = 0; i <  projectList[projectNo]
      .iconSections.length; i++) {
        currntframePosPercentList.clear();


  projectList[projectNo]
      .iconSections[i]
      .frames
      .forEach((e) {
    // log("fore ${e.frameNo}");
    currntframePosPercentList.add(e.singleFrameModel.framePosition);
  });

  List<double> templist = List.from(currntframePosPercentList);
  // log("fore ${templist}");
  templist.sort();
  currntframePosPercentList = List.from(templist);
  // log("foreafte ${templist}");
  framePosPercentListForAllIconSections[i] =
      List.from(templist);
    
  }

}
