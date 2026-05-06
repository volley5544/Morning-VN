// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LeaveDetailsStruct extends FFFirebaseStruct {
  LeaveDetailsStruct({
    String? leaveId,
    String? leaveName,
    String? leaveDate,
    String? leaveDateFormat,
    String? leavePeriod,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveId = leaveId,
        _leaveName = leaveName,
        _leaveDate = leaveDate,
        _leaveDateFormat = leaveDateFormat,
        _leavePeriod = leavePeriod,
        super(firestoreUtilData);

  // "LEAVE_ID" field.
  String? _leaveId;
  String get leaveId => _leaveId ?? '';
  set leaveId(String? val) => _leaveId = val;

  bool hasLeaveId() => _leaveId != null;

  // "LEAVE_NAME" field.
  String? _leaveName;
  String get leaveName => _leaveName ?? '';
  set leaveName(String? val) => _leaveName = val;

  bool hasLeaveName() => _leaveName != null;

  // "LEAVE_DATE" field.
  String? _leaveDate;
  String get leaveDate => _leaveDate ?? '';
  set leaveDate(String? val) => _leaveDate = val;

  bool hasLeaveDate() => _leaveDate != null;

  // "LEAVE_DATE_FORMAT" field.
  String? _leaveDateFormat;
  String get leaveDateFormat => _leaveDateFormat ?? '';
  set leaveDateFormat(String? val) => _leaveDateFormat = val;

  bool hasLeaveDateFormat() => _leaveDateFormat != null;

  // "LEAVE_PERIOD" field.
  String? _leavePeriod;
  String get leavePeriod => _leavePeriod ?? '';
  set leavePeriod(String? val) => _leavePeriod = val;

  bool hasLeavePeriod() => _leavePeriod != null;

  static LeaveDetailsStruct fromMap(Map<String, dynamic> data) =>
      LeaveDetailsStruct(
        leaveId: data['LEAVE_ID'] as String?,
        leaveName: data['LEAVE_NAME'] as String?,
        leaveDate: data['LEAVE_DATE'] as String?,
        leaveDateFormat: data['LEAVE_DATE_FORMAT'] as String?,
        leavePeriod: data['LEAVE_PERIOD'] as String?,
      );

  static LeaveDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'LEAVE_ID': _leaveId,
        'LEAVE_NAME': _leaveName,
        'LEAVE_DATE': _leaveDate,
        'LEAVE_DATE_FORMAT': _leaveDateFormat,
        'LEAVE_PERIOD': _leavePeriod,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'LEAVE_ID': serializeParam(
          _leaveId,
          ParamType.String,
        ),
        'LEAVE_NAME': serializeParam(
          _leaveName,
          ParamType.String,
        ),
        'LEAVE_DATE': serializeParam(
          _leaveDate,
          ParamType.String,
        ),
        'LEAVE_DATE_FORMAT': serializeParam(
          _leaveDateFormat,
          ParamType.String,
        ),
        'LEAVE_PERIOD': serializeParam(
          _leavePeriod,
          ParamType.String,
        ),
      }.withoutNulls;

  static LeaveDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveDetailsStruct(
        leaveId: deserializeParam(
          data['LEAVE_ID'],
          ParamType.String,
          false,
        ),
        leaveName: deserializeParam(
          data['LEAVE_NAME'],
          ParamType.String,
          false,
        ),
        leaveDate: deserializeParam(
          data['LEAVE_DATE'],
          ParamType.String,
          false,
        ),
        leaveDateFormat: deserializeParam(
          data['LEAVE_DATE_FORMAT'],
          ParamType.String,
          false,
        ),
        leavePeriod: deserializeParam(
          data['LEAVE_PERIOD'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LeaveDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LeaveDetailsStruct &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveDate == other.leaveDate &&
        leaveDateFormat == other.leaveDateFormat &&
        leavePeriod == other.leavePeriod;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([leaveId, leaveName, leaveDate, leaveDateFormat, leavePeriod]);
}

LeaveDetailsStruct createLeaveDetailsStruct({
  String? leaveId,
  String? leaveName,
  String? leaveDate,
  String? leaveDateFormat,
  String? leavePeriod,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveDetailsStruct(
      leaveId: leaveId,
      leaveName: leaveName,
      leaveDate: leaveDate,
      leaveDateFormat: leaveDateFormat,
      leavePeriod: leavePeriod,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeaveDetailsStruct? updateLeaveDetailsStruct(
  LeaveDetailsStruct? leaveDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveDetailsStructData(
  Map<String, dynamic> firestoreData,
  LeaveDetailsStruct? leaveDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveDetails == null) {
    return;
  }
  if (leaveDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveDetailsData =
      getLeaveDetailsFirestoreData(leaveDetails, forFieldValue);
  final nestedData =
      leaveDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveDetailsFirestoreData(
  LeaveDetailsStruct? leaveDetails, [
  bool forFieldValue = false,
]) {
  if (leaveDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveDetails.toMap());

  // Add any Firestore field values
  mapToFirestore(leaveDetails.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveDetailsListFirestoreData(
  List<LeaveDetailsStruct>? leaveDetailss,
) =>
    leaveDetailss?.map((e) => getLeaveDetailsFirestoreData(e, true)).toList() ??
    [];
