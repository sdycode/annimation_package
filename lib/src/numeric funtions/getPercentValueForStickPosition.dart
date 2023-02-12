
import 'package:annimation/src/sizes/sizes_landscape.dart';
import 'package:annimation/src/utils/extensions.dart';
import 'package:flutter/material.dart';

double getPercentValueForStickPosition(double v, BuildContext context) {
  double range = animTimelineWidthFactor.sw(context) - timelineBarH.sw(context);
  
  return (v/range)*100;
}
