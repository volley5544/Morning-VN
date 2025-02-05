import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'leave_calendar_component_model.dart';
export 'leave_calendar_component_model.dart';

class LeaveCalendarComponentWidget extends StatefulWidget {
  const LeaveCalendarComponentWidget({
    super.key,
    this.holidayList,
    this.currentYear,
    required this.nextYear,
    this.leaveTime,
    String? currentYearSelectableDates,
    this.nextYearSelectableDates,
    this.startDate,
    this.endDate,
    required this.previousYear,
    this.previousYearSelectableDates,
  }) : currentYearSelectableDates = currentYearSelectableDates ?? '';

  final List<String>? holidayList;
  final String? currentYear;
  final String? nextYear;
  final String? leaveTime;
  final String currentYearSelectableDates;
  final String? nextYearSelectableDates;
  final String? startDate;
  final String? endDate;
  final String? previousYear;
  final String? previousYearSelectableDates;

  @override
  State<LeaveCalendarComponentWidget> createState() =>
      _LeaveCalendarComponentWidgetState();
}

class _LeaveCalendarComponentWidgetState
    extends State<LeaveCalendarComponentWidget> {
  late LeaveCalendarComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaveCalendarComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: custom_widgets.LeaveCalendarWidget(
          width: double.infinity,
          height: double.infinity,
          todayColor: const Color(0xFFFF843D),
          selectedColor: const Color(0xFFFF843D),
          selectedTextColor: FlutterFlowTheme.of(context).secondaryBackground,
          holidaysList: widget.holidayList,
          currentDate: getCurrentTimestamp,
          currentYear: widget.currentYear,
          nextYear: widget.nextYear,
          currentYearSelectableDates: widget.leaveTime != 'full'
              ? '1'
              : ((double.parse(widget.currentYearSelectableDates).toInt())
                  .toString()),
          nextYearSelectableDates: widget.leaveTime != 'full'
              ? '1'
              : ((double.parse((widget.nextYearSelectableDates!)).toInt())
                  .toString()),
          startdate: widget.startDate,
          enddate: widget.endDate,
          previousYear: widget.previousYear,
          previousYearSelectableDates: widget.leaveTime != 'full'
              ? '1'
              : ((double.parse((widget.previousYearSelectableDates!)).toInt())
                  .toString()),
        ),
      ),
    );
  }
}
