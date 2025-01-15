// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LaveDetailStruct extends FFFirebaseStruct {
  LaveDetailStruct({
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

  static LaveDetailStruct fromMap(Map<String, dynamic> data) =>
      LaveDetailStruct(
        leaveId: data['leave_id'] as String?,
        leaveName: data['leave_name'] as String?,
        leaveDate: data['leave_date'] as String?,
      );

  static LaveDetailStruct? maybeFromMap(dynamic data) => data is Map
      ? LaveDetailStruct.fromMap(data.cast<String, dynamic>())
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

  static LaveDetailStruct fromSerializableMap(Map<String, dynamic> data) =>
      LaveDetailStruct(
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
  String toString() => 'LaveDetailStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LaveDetailStruct &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveDate == other.leaveDate;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([leaveId, leaveName, leaveDate]);
}

LaveDetailStruct createLaveDetailStruct({
  String? leaveId,
  String? leaveName,
  String? leaveDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LaveDetailStruct(
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

LaveDetailStruct? updateLaveDetailStruct(
  LaveDetailStruct? laveDetail, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    laveDetail
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLaveDetailStructData(
  Map<String, dynamic> firestoreData,
  LaveDetailStruct? laveDetail,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (laveDetail == null) {
    return;
  }
  if (laveDetail.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && laveDetail.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final laveDetailData = getLaveDetailFirestoreData(laveDetail, forFieldValue);
  final nestedData = laveDetailData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = laveDetail.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLaveDetailFirestoreData(
  LaveDetailStruct? laveDetail, [
  bool forFieldValue = false,
]) {
  if (laveDetail == null) {
    return {};
  }
  final firestoreData = mapToFirestore(laveDetail.toMap());

  // Add any Firestore field values
  laveDetail.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLaveDetailListFirestoreData(
  List<LaveDetailStruct>? laveDetails,
) =>
    laveDetails?.map((e) => getLaveDetailFirestoreData(e, true)).toList() ?? [];
