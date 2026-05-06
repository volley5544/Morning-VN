// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CalendarDataStruct extends FFFirebaseStruct {
  CalendarDataStruct({
    String? date,
    String? type,
    String? leaveId,
    String? name,
    String? period,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _type = type,
        _leaveId = leaveId,
        _name = name,
        _period = period,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "leave_id" field.
  String? _leaveId;
  String get leaveId => _leaveId ?? '';
  set leaveId(String? val) => _leaveId = val;

  bool hasLeaveId() => _leaveId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "period" field.
  String? _period;
  String get period => _period ?? '';
  set period(String? val) => _period = val;

  bool hasPeriod() => _period != null;

  static CalendarDataStruct fromMap(Map<String, dynamic> data) =>
      CalendarDataStruct(
        date: data['date'] as String?,
        type: data['type'] as String?,
        leaveId: data['leave_id'] as String?,
        name: data['name'] as String?,
        period: data['period'] as String?,
      );

  static CalendarDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'type': _type,
        'leave_id': _leaveId,
        'name': _name,
        'period': _period,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'leave_id': serializeParam(
          _leaveId,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'period': serializeParam(
          _period,
          ParamType.String,
        ),
      }.withoutNulls;

  static CalendarDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CalendarDataStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        leaveId: deserializeParam(
          data['leave_id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        period: deserializeParam(
          data['period'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CalendarDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalendarDataStruct &&
        date == other.date &&
        type == other.type &&
        leaveId == other.leaveId &&
        name == other.name &&
        period == other.period;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([date, type, leaveId, name, period]);
}

CalendarDataStruct createCalendarDataStruct({
  String? date,
  String? type,
  String? leaveId,
  String? name,
  String? period,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarDataStruct(
      date: date,
      type: type,
      leaveId: leaveId,
      name: name,
      period: period,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarDataStruct? updateCalendarDataStruct(
  CalendarDataStruct? calendarData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarDataStructData(
  Map<String, dynamic> firestoreData,
  CalendarDataStruct? calendarData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarData == null) {
    return;
  }
  if (calendarData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarDataData =
      getCalendarDataFirestoreData(calendarData, forFieldValue);
  final nestedData =
      calendarDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = calendarData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarDataFirestoreData(
  CalendarDataStruct? calendarData, [
  bool forFieldValue = false,
]) {
  if (calendarData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarData.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarDataListFirestoreData(
  List<CalendarDataStruct>? calendarDatas,
) =>
    calendarDatas?.map((e) => getCalendarDataFirestoreData(e, true)).toList() ??
    [];
