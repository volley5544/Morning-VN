// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ApproveListDateDetailDataModelStruct extends FFFirebaseStruct {
  ApproveListDateDetailDataModelStruct({
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

  static ApproveListDateDetailDataModelStruct fromMap(
          Map<String, dynamic> data) =>
      ApproveListDateDetailDataModelStruct(
        leaveId: data['leave_id'] as String?,
        leaveName: data['leave_name'] as String?,
        leaveDate: data['leave_date'] as String?,
      );

  static ApproveListDateDetailDataModelStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? ApproveListDateDetailDataModelStruct.fromMap(
              data.cast<String, dynamic>())
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

  static ApproveListDateDetailDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ApproveListDateDetailDataModelStruct(
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
  String toString() => 'ApproveListDateDetailDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ApproveListDateDetailDataModelStruct &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveDate == other.leaveDate;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([leaveId, leaveName, leaveDate]);
}

ApproveListDateDetailDataModelStruct
    createApproveListDateDetailDataModelStruct({
  String? leaveId,
  String? leaveName,
  String? leaveDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
        ApproveListDateDetailDataModelStruct(
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

ApproveListDateDetailDataModelStruct?
    updateApproveListDateDetailDataModelStruct(
  ApproveListDateDetailDataModelStruct? approveListDateDetailDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
        approveListDateDetailDataModel
          ?..firestoreUtilData = FirestoreUtilData(
            clearUnsetFields: clearUnsetFields,
            create: create,
          );

void addApproveListDateDetailDataModelStructData(
  Map<String, dynamic> firestoreData,
  ApproveListDateDetailDataModelStruct? approveListDateDetailDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (approveListDateDetailDataModel == null) {
    return;
  }
  if (approveListDateDetailDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      approveListDateDetailDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final approveListDateDetailDataModelData =
      getApproveListDateDetailDataModelFirestoreData(
          approveListDateDetailDataModel, forFieldValue);
  final nestedData = approveListDateDetailDataModelData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      approveListDateDetailDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getApproveListDateDetailDataModelFirestoreData(
  ApproveListDateDetailDataModelStruct? approveListDateDetailDataModel, [
  bool forFieldValue = false,
]) {
  if (approveListDateDetailDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(approveListDateDetailDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(approveListDateDetailDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getApproveListDateDetailDataModelListFirestoreData(
  List<ApproveListDateDetailDataModelStruct>? approveListDateDetailDataModels,
) =>
    approveListDateDetailDataModels
        ?.map((e) => getApproveListDateDetailDataModelFirestoreData(e, true))
        .toList() ??
    [];
