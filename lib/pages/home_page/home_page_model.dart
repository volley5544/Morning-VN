import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  List<CheckinDataStruct> currentMonthData = [];
  void addToCurrentMonthData(CheckinDataStruct item) =>
      currentMonthData.add(item);
  void removeFromCurrentMonthData(CheckinDataStruct item) =>
      currentMonthData.remove(item);
  void removeAtIndexFromCurrentMonthData(int index) =>
      currentMonthData.removeAt(index);
  void insertAtIndexInCurrentMonthData(int index, CheckinDataStruct item) =>
      currentMonthData.insert(index, item);
  void updateCurrentMonthDataAtIndex(
          int index, Function(CheckinDataStruct) updateFn) =>
      currentMonthData[index] = updateFn(currentMonthData[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
