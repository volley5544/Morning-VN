// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CheckinDataStruct extends FFFirebaseStruct {
  CheckinDataStruct({
    String? date,
    String? dayName,
    String? dateName,
    String? checkIn,
    String? checkOut,
    String? employeeId,
    String? status,
    String? color,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _dayName = dayName,
        _dateName = dateName,
        _checkIn = checkIn,
        _checkOut = checkOut,
        _employeeId = employeeId,
        _status = status,
        _color = color,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "day_name" field.
  String? _dayName;
  String get dayName => _dayName ?? '';
  set dayName(String? val) => _dayName = val;

  bool hasDayName() => _dayName != null;

  // "date_name" field.
  String? _dateName;
  String get dateName => _dateName ?? '';
  set dateName(String? val) => _dateName = val;

  bool hasDateName() => _dateName != null;

  // "check_in" field.
  String? _checkIn;
  String get checkIn => _checkIn ?? '';
  set checkIn(String? val) => _checkIn = val;

  bool hasCheckIn() => _checkIn != null;

  // "check_out" field.
  String? _checkOut;
  String get checkOut => _checkOut ?? '';
  set checkOut(String? val) => _checkOut = val;

  bool hasCheckOut() => _checkOut != null;

  // "employee_id" field.
  String? _employeeId;
  String get employeeId => _employeeId ?? '';
  set employeeId(String? val) => _employeeId = val;

  bool hasEmployeeId() => _employeeId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  static CheckinDataStruct fromMap(Map<String, dynamic> data) =>
      CheckinDataStruct(
        date: data['date'] as String?,
        dayName: data['day_name'] as String?,
        dateName: data['date_name'] as String?,
        checkIn: data['check_in'] as String?,
        checkOut: data['check_out'] as String?,
        employeeId: data['employee_id'] as String?,
        status: data['status'] as String?,
        color: data['color'] as String?,
      );

  static CheckinDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CheckinDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'day_name': _dayName,
        'date_name': _dateName,
        'check_in': _checkIn,
        'check_out': _checkOut,
        'employee_id': _employeeId,
        'status': _status,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'day_name': serializeParam(
          _dayName,
          ParamType.String,
        ),
        'date_name': serializeParam(
          _dateName,
          ParamType.String,
        ),
        'check_in': serializeParam(
          _checkIn,
          ParamType.String,
        ),
        'check_out': serializeParam(
          _checkOut,
          ParamType.String,
        ),
        'employee_id': serializeParam(
          _employeeId,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
      }.withoutNulls;

  static CheckinDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CheckinDataStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        dayName: deserializeParam(
          data['day_name'],
          ParamType.String,
          false,
        ),
        dateName: deserializeParam(
          data['date_name'],
          ParamType.String,
          false,
        ),
        checkIn: deserializeParam(
          data['check_in'],
          ParamType.String,
          false,
        ),
        checkOut: deserializeParam(
          data['check_out'],
          ParamType.String,
          false,
        ),
        employeeId: deserializeParam(
          data['employee_id'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CheckinDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CheckinDataStruct &&
        date == other.date &&
        dayName == other.dayName &&
        dateName == other.dateName &&
        checkIn == other.checkIn &&
        checkOut == other.checkOut &&
        employeeId == other.employeeId &&
        status == other.status &&
        color == other.color;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [date, dayName, dateName, checkIn, checkOut, employeeId, status, color]);
}

CheckinDataStruct createCheckinDataStruct({
  String? date,
  String? dayName,
  String? dateName,
  String? checkIn,
  String? checkOut,
  String? employeeId,
  String? status,
  String? color,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CheckinDataStruct(
      date: date,
      dayName: dayName,
      dateName: dateName,
      checkIn: checkIn,
      checkOut: checkOut,
      employeeId: employeeId,
      status: status,
      color: color,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CheckinDataStruct? updateCheckinDataStruct(
  CheckinDataStruct? checkinData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    checkinData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCheckinDataStructData(
  Map<String, dynamic> firestoreData,
  CheckinDataStruct? checkinData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (checkinData == null) {
    return;
  }
  if (checkinData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && checkinData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final checkinDataData =
      getCheckinDataFirestoreData(checkinData, forFieldValue);
  final nestedData =
      checkinDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = checkinData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCheckinDataFirestoreData(
  CheckinDataStruct? checkinData, [
  bool forFieldValue = false,
]) {
  if (checkinData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(checkinData.toMap());

  // Add any Firestore field values
  checkinData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCheckinDataListFirestoreData(
  List<CheckinDataStruct>? checkinDatas,
) =>
    checkinDatas?.map((e) => getCheckinDataFirestoreData(e, true)).toList() ??
    [];
