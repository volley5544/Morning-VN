// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LeaveDetailStruct extends FFFirebaseStruct {
  LeaveDetailStruct({
    String? leaveId,
    String? leaveName,
    String? leaveDate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveId = leaveId,
        _leaveName = leaveName,
        _leaveDate = leaveDate,
        super(firestoreUtilData);

  // "leave_id" field.
  String? _leaveId;
  String get leaveId => _leaveId ?? '';
  set leaveId(String? val) => _leaveId = val;

  bool hasLeaveId() => _leaveId != null;

  // "leave_name" field.
  String? _leaveName;
  String get leaveName => _leaveName ?? '';
  set leaveName(String? val) => _leaveName = val;

  bool hasLeaveName() => _leaveName != null;

  // "leave_date" field.
  String? _leaveDate;
  String get leaveDate => _leaveDate ?? '';
  set leaveDate(String? val) => _leaveDate = val;

  bool hasLeaveDate() => _leaveDate != null;

  static LeaveDetailStruct fromMap(Map<String, dynamic> data) =>
      LeaveDetailStruct(
        leaveId: data['leave_id'] as String?,
        leaveName: data['leave_name'] as String?,
        leaveDate: data['leave_date'] as String?,
      );

  static LeaveDetailStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveDetailStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'leave_id': _leaveId,
        'leave_name': _leaveName,
        'leave_date': _leaveDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leave_id': serializeParam(
          _leaveId,
          ParamType.String,
        ),
        'leave_name': serializeParam(
          _leaveName,
          ParamType.String,
        ),
        'leave_date': serializeParam(
          _leaveDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static LeaveDetailStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveDetailStruct(
        leaveId: deserializeParam(
          data['leave_id'],
          ParamType.String,
          false,
        ),
        leaveName: deserializeParam(
          data['leave_name'],
          ParamType.String,
          false,
        ),
        leaveDate: deserializeParam(
          data['leave_date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LeaveDetailStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LeaveDetailStruct &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveDate == other.leaveDate;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([leaveId, leaveName, leaveDate]);
}

LeaveDetailStruct createLeaveDetailStruct({
  String? leaveId,
  String? leaveName,
  String? leaveDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveDetailStruct(
      leaveId: leaveId,
      leaveName: leaveName,
      leaveDate: leaveDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeaveDetailStruct? updateLeaveDetailStruct(
  LeaveDetailStruct? leaveDetail, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveDetail
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveDetailStructData(
  Map<String, dynamic> firestoreData,
  LeaveDetailStruct? leaveDetail,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveDetail == null) {
    return;
  }
  if (leaveDetail.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveDetail.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveDetailData =
      getLeaveDetailFirestoreData(leaveDetail, forFieldValue);
  final nestedData =
      leaveDetailData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveDetail.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveDetailFirestoreData(
  LeaveDetailStruct? leaveDetail, [
  bool forFieldValue = false,
]) {
  if (leaveDetail == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveDetail.toMap());

  // Add any Firestore field values
  mapToFirestore(leaveDetail.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveDetailListFirestoreData(
  List<LeaveDetailStruct>? leaveDetails,
) =>
    leaveDetails?.map((e) => getLeaveDetailFirestoreData(e, true)).toList() ??
    [];
