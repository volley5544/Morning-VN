import '/flutter_flow/flutter_flow_util.dart';
import 'datail_leave_requet_widget.dart' show DatailLeaveRequetWidget;
import 'package:flutter/material.dart';

class DatailLeaveRequetModel extends FlutterFlowModel<DatailLeaveRequetWidget> {
  ///  Local state fields for this component.

  List<dynamic> leaveDetailList = [];
  void addToLeaveDetailList(dynamic item) => leaveDetailList.add(item);
  void removeFromLeaveDetailList(dynamic item) => leaveDetailList.remove(item);
  void removeAtIndexFromLeaveDetailList(int index) =>
      leaveDetailList.removeAt(index);
  void insertAtIndexInLeaveDetailList(int index, dynamic item) =>
      leaveDetailList.insert(index, item);
  void updateLeaveDetailListAtIndex(int index, Function(dynamic) updateFn) =>
      leaveDetailList[index] = updateFn(leaveDetailList[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
