// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AllLeaveListStruct extends FFFirebaseStruct {
  AllLeaveListStruct({
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

  static AllLeaveListStruct fromMap(Map<String, dynamic> data) =>
      AllLeaveListStruct(
        leaveDate: data['leave_date'] as String?,
        leaveType: data['leave_type'] as String?,
        leaveName: data['leave_name'] as String?,
        leavePeriod: data['leave_period'] as String?,
      );

  static AllLeaveListStruct? maybeFromMap(dynamic data) => data is Map
      ? AllLeaveListStruct.fromMap(data.cast<String, dynamic>())
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

  static AllLeaveListStruct fromSerializableMap(Map<String, dynamic> data) =>
      AllLeaveListStruct(
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
  String toString() => 'AllLeaveListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AllLeaveListStruct &&
        leaveDate == other.leaveDate &&
        leaveType == other.leaveType &&
        leaveName == other.leaveName &&
        leavePeriod == other.leavePeriod;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([leaveDate, leaveType, leaveName, leavePeriod]);
}

AllLeaveListStruct createAllLeaveListStruct({
  String? leaveDate,
  String? leaveType,
  String? leaveName,
  String? leavePeriod,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AllLeaveListStruct(
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

AllLeaveListStruct? updateAllLeaveListStruct(
  AllLeaveListStruct? allLeaveList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    allLeaveList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAllLeaveListStructData(
  Map<String, dynamic> firestoreData,
  AllLeaveListStruct? allLeaveList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (allLeaveList == null) {
    return;
  }
  if (allLeaveList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && allLeaveList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final allLeaveListData =
      getAllLeaveListFirestoreData(allLeaveList, forFieldValue);
  final nestedData =
      allLeaveListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = allLeaveList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAllLeaveListFirestoreData(
  AllLeaveListStruct? allLeaveList, [
  bool forFieldValue = false,
]) {
  if (allLeaveList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(allLeaveList.toMap());

  // Add any Firestore field values
  allLeaveList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAllLeaveListListFirestoreData(
  List<AllLeaveListStruct>? allLeaveLists,
) =>
    allLeaveLists?.map((e) => getAllLeaveListFirestoreData(e, true)).toList() ??
    [];
