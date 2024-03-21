import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timelines/timelines.dart';

class TimelineCard extends StatelessWidget {
  String statusCode;
  TimelineCard({Key? key, required this.statusCode}) : super(key: key);

  Widget line(String hexColor) {
    return SizedBox(
        height: 15.0,
        child: SolidLineConnector(
          thickness: 3,
          color: HexColor(hexColor),
        ));
  }

  Widget simple(String hexColor) {
    return SizedBox(
        height: 15.0,
        child: TimelineNode.simple(
          color: HexColor(hexColor),
        ));
  }

  Map<String, dynamic> indexMapper() {
    return {
      '0': line('#DB771A'),
      '1': line('#E5E5E5'),
    };
  }

  Map<String, dynamic> indexDotMapper() {
    return {
      '0': simple('#DB771A'),
      '1': simple('#E5E5E5'),
    };
  }

  Map<String, dynamic> lineMapper(int index) {
    return {
      //'รอพิจารณา': indexMapper()[index == 0 ? '0' : '0'],
      'รอตรวจสอบและโอนเงิน': indexMapper()[index == 2 ? '1' : '0'],
      'อยู่ระหว่างดำเนินการ': indexMapper()[index == 1 ? '1' : '1'],
      'รออนุมัติ': indexMapper()[index == 2 ? '1' : '0'],
      'โอนเงินสำเร็จ': indexMapper()[index == 3 ? '1 ' : '0'],
      'ไม่ผ่านการตรวจสอบ': indexMapper()[index == 0 ? '1' : '1'],
    };
  }

  Map<String, dynamic> dotMapper(int index) {
    return {
      'รอตรวจสอบและโอนเงิน': indexDotMapper()[index == 2 ? '1' : '0'],
      'อยู่ระหว่างดำเนินการ': indexDotMapper()[index == 0 ? '0' : '1'],
      'รออนุมัติ': indexDotMapper()[index == 2 ? '1' : '0'],
      'โอนเงินสำเร็จ': indexDotMapper()[index == 3 ? '0 ' : '0'],
      'ไม่ผ่านการตรวจสอบ': indexDotMapper()[index == 0 ? '1' : '1'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: FixedTimeline.tileBuilder(
        direction: Axis.horizontal,
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          connectorBuilder: (context, index, type) {
            return lineMapper(index)[statusCode];
          },
          indicatorBuilder: (context, index) {
            return dotMapper(index)[statusCode];
          },
          itemExtent: 40.0,
          itemCount: 3,
        ),
      ),
    );
  }
}
