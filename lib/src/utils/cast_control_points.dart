import 'package:annimation/src/models/new_full_user_model.dart';
import 'package:annimation/src/sizes/drawing_grid_canvas_fields.dart';
import 'package:flutter/material.dart';

Map<String, Point> castControlPoints(Map<int, Offset> controlMidPoints) {
  Map<String, Point> castedPoints =
      controlMidPoints.map((int key, Offset value) {
    // return {key.toString(), Point(x: value.dx, y: value.dy)};
    return MapEntry(key.toString(), Point(x: value.dx, y: value.dy));
    // Map<String, Point>.from({"0": Point(x: 0, y: 0)});
  });
  return castedPoints;
}

Map<int, Offset> reverseCastControlPointsToIntOffset(
    Map<String, Point> controlMidPoints, Size size) {
  Map<int, Offset> controlPoints = {};
  controlPoints = controlMidPoints.map((key, value) {
    return MapEntry(int.parse(key), Offset(value.x*(size.width /biggerSize.width), value.y*(size.width /biggerSize.width)));
  });
  return controlPoints;
}
