
double get_modified_percentvalue_for_preframeno(
    int currentPreFrameNo, double interPercentValue, int iconNo,Map<int, List<double>> framePosPercentListForAllIconSections
    ) {
  if (framePosPercentListForAllIconSections.containsKey(iconNo)) {
    if (currentPreFrameNo + 1 < framePosPercentListForAllIconSections[iconNo]!.length) {
      double fullRange = framePosPercentListForAllIconSections[iconNo]![currentPreFrameNo + 1] -
          framePosPercentListForAllIconSections[iconNo]![currentPreFrameNo];
      double currntValue =
          interPercentValue - framePosPercentListForAllIconSections[iconNo]![currentPreFrameNo];
      return (currntValue) / (fullRange);
// if(currentPreFrameNo +1< currntframePosPercentList.length){
// double fullRange = currntframePosPercentList[currentPreFrameNo+1]-currntframePosPercentList[currentPreFrameNo];
// double currntValue = interPercentValue -currntframePosPercentList[currentPreFrameNo];
// return (currntValue)/(fullRange);
    }
  }

  return 0.0;
}
