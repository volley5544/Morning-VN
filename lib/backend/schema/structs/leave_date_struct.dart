// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LeaveDateStruct extends FFFirebaseStruct {
  LeaveDateStruct({
    String? leaveDate,
    String? leaveType,
    String? leaveName,
    String? leavePeriod,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveDate = leaveDate,
        _leaveType = leaveType,
        _leaveName = leaveName,
        _leavePeriod = leavePeriod,
        super(firestoreUtilData);

  // "leave_date" field.
  String? _leaveDate;
  String get leaveDate => _leaveDate ?? '';
  set leaveDate(String? val) => _leaveDate = val;

  bool hasLeaveDate() => _leaveDate != null;

  // "leave_type" field.
  String? _leaveType;
  String get leaveType => _leaveType ?? '';
  set leaveType(String? val) => _leaveType = val;

  bool hasLeaveType() => _leaveType != null;

  // "leave_name" field.
  String? _leaveName;
  String get leaveName => _leaveName ?? '';
  set leaveName(String? val) => _leaveName = val;

  bool hasLeaveName() => _leaveName != null;

  // "leave_period" field.
  String? _leavePeriod;
  String get leavePeriod => _leavePeriod ?? '';
  set leavePeriod(String? val) => _leavePeriod = val;

  bool hasLeavePeriod() => _leavePeriod != null;

  static LeaveDateStruct fromMap(Map<String, dynamic> data) => LeaveDateStruct(
        leaveDate: data['leave_date'] as String?,
        leaveType: data['leave_type'] as String?,
        leaveName: data['leave_name'] as String?,
        leavePeriod: data['leave_period'] as String?,
      );

  static LeaveDateStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveDateStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'leave_date': _leaveDate,
        'leave_type': _leaveType,
        'leave_name': _leaveName,
        'leave_period': _leavePeriod,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leave_date': serializeParam(
          _leaveDate,
          ParamType.String,
        ),
        'leave_type': serializeParam(
          _leaveType,
          ParamType.String,
        ),
        'leave_name': serializeParam(
          _leaveName,
          ParamType.String,
        ),
        'leave_period': serializeParam(
          _leavePeriod,
          ParamType.String,
        ),
      }.withoutNulls;

  static LeaveDateStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveDateStruct(
        leaveDate: deserializeParam(
          data['leave_date'],
          ParamType.String,
          false,
        ),
        leaveType: deserializeParam(
          data['leave_type'],
          ParamType.String,
          false,
        ),
        leaveName: deserializeParam(
          data['leave_name'],
          ParamType.String,
          false,
        ),
        leavePeriod: deserializeParam(
          data['leave_period'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LeaveDateStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LeaveDateStruct &&
        leaveDate == other.leaveDate &&
        leaveType == other.leaveType &&
        leaveName == other.leaveName &&
        leavePeriod == other.leavePeriod;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([leaveDate, leaveType, leaveName, leavePeriod]);
}

LeaveDateStruct createLeaveDateStruct({
  String? leaveDate,
  String? leaveType,
  String? leaveName,
  String? leavePeriod,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveDateStruct(
      leaveDate: leaveDate,
      leaveType: leaveType,
      leaveName: leaveName,
      leavePeriod: leavePeriod,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeaveDateStruct? updateLeaveDateStruct(
  LeaveDateStruct? leaveDateStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveDateStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveDateStructData(
  Map<String, dynamic> firestoreData,
  LeaveDateStruct? leaveDateStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveDateStruct == null) {
    return;
  }
  if (leaveDateStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveDateStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveDateStructData =
      getLeaveDateFirestoreData(leaveDateStruct, forFieldValue);
  final nestedData =
      leaveDateStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveDateStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveDateFirestoreData(
  LeaveDateStruct? leaveDateStruct, [
  bool forFieldValue = false,
]) {
  if (leaveDateStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveDateStruct.toMap());

  // Add any Firestore field values
  leaveDateStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveDateListFirestoreData(
  List<LeaveDateStruct>? leaveDateStructs,
) =>
    leaveDateStructs?.map((e) => getLeaveDateFirestoreData(e, true)).toList() ??
    [];
