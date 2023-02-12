import 'dart:convert';
import 'dart:developer';

import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/numeric%20funtions/update_framePos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimationData {
  Project project;
  List<int> iconSectionIndexesToIncludeInAnimationList = [];
  List<double> currntframePosPercentList = [0, 100];
  Map<int, List<double>> framePosPercentListForAllIconSections = {
    0: [0, 100]
  };
  AnimationData(
      {required this.project,
      this.iconSectionIndexesToIncludeInAnimationList = const [],
      this.currntframePosPercentList = const [0, 100],
      this.framePosPercentListForAllIconSections = const {
        0: [0, 100]
      }});

  static Future<AnimationData?> loadAnimationDataFromAsset(
    String filePath,
  ) async {
    Map<String, dynamic> proj = {};
    try {
      String data = await rootBundle.loadString(filePath);

      proj = json.decode(data);
      log("proj done");
      Project project = Project.fromMap(proj);
      
      AnimationData animationData = AnimationData(
          project: project,
          iconSectionIndexesToIncludeInAnimationList: [],
          currntframePosPercentList: [
            0,
            100
          ],
          framePosPercentListForAllIconSections: {
            0: [0, 100]
          });
      animationData.iconSectionIndexesToIncludeInAnimationList.clear();
      for (var i = 0; i < project.iconSections.length; i++) {
        animationData.iconSectionIndexesToIncludeInAnimationList.add(i);
      }
      // log("animationData.currntframePosPercentList before ${ animationData.currntframePosPercentList}");
      updateFramePostListForAllsectionsInProject(
          [project],
          animationData.currntframePosPercentList,
          animationData.framePosPercentListForAllIconSections);
      // log("animationData.currntframePosPercentList after ${ animationData.currntframePosPercentList}");
      return animationData;
      
    } catch (e) {
      log("animationData loadAnimationDataFromAsset  err $e");
    }
    return null;
  }
}
