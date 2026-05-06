// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ApproveListDataModelStruct extends FFFirebaseStruct {
  ApproveListDataModelStruct({
    int? year,
    String? cancel,
    String? approve,
    String? notApprove,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _year = year,
        _cancel = cancel,
        _approve = approve,
        _notApprove = notApprove,
        super(firestoreUtilData);

  // "year" field.
  int? _year;
  int get year => _year ?? 0;
  set year(int? val) => _year = val;

  void incrementYear(int amount) => year = year + amount;

  bool hasYear() => _year != null;

  // "Cancel" field.
  String? _cancel;
  String get cancel => _cancel ?? '';
  set cancel(String? val) => _cancel = val;

  bool hasCancel() => _cancel != null;

  // "Approve" field.
  String? _approve;
  String get approve => _approve ?? '';
  set approve(String? val) => _approve = val;

  bool hasApprove() => _approve != null;

  // "NotApprove" field.
  String? _notApprove;
  String get notApprove => _notApprove ?? '';
  set notApprove(String? val) => _notApprove = val;

  bool hasNotApprove() => _notApprove != null;

  static ApproveListDataModelStruct fromMap(Map<String, dynamic> data) =>
      ApproveListDataModelStruct(
        year: castToType<int>(data['year']),
        cancel: data['Cancel'] as String?,
        approve: data['Approve'] as String?,
        notApprove: data['NotApprove'] as String?,
      );

  static ApproveListDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? ApproveListDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'year': _year,
        'Cancel': _cancel,
        'Approve': _approve,
        'NotApprove': _notApprove,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'year': serializeParam(
          _year,
          ParamType.int,
        ),
        'Cancel': serializeParam(
          _cancel,
          ParamType.String,
        ),
        'Approve': serializeParam(
          _approve,
          ParamType.String,
        ),
        'NotApprove': serializeParam(
          _notApprove,
          ParamType.String,
        ),
      }.withoutNulls;

  static ApproveListDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ApproveListDataModelStruct(
        year: deserializeParam(
          data['year'],
          ParamType.int,
          false,
        ),
        cancel: deserializeParam(
          data['Cancel'],
          ParamType.String,
          false,
        ),
        approve: deserializeParam(
          data['Approve'],
          ParamType.String,
          false,
        ),
        notApprove: deserializeParam(
          data['NotApprove'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ApproveListDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ApproveListDataModelStruct &&
        year == other.year &&
        cancel == other.cancel &&
        approve == other.approve &&
        notApprove == other.notApprove;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([year, cancel, approve, notApprove]);
}

ApproveListDataModelStruct createApproveListDataModelStruct({
  int? year,
  String? cancel,
  String? approve,
  String? notApprove,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ApproveListDataModelStruct(
      year: year,
      cancel: cancel,
      approve: approve,
      notApprove: notApprove,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ApproveListDataModelStruct? updateApproveListDataModelStruct(
  ApproveListDataModelStruct? approveListDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    approveListDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addApproveListDataModelStructData(
  Map<String, dynamic> firestoreData,
  ApproveListDataModelStruct? approveListDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (approveListDataModel == null) {
    return;
  }
  if (approveListDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && approveListDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final approveListDataModelData =
      getApproveListDataModelFirestoreData(approveListDataModel, forFieldValue);
  final nestedData =
      approveListDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      approveListDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getApproveListDataModelFirestoreData(
  ApproveListDataModelStruct? approveListDataModel, [
  bool forFieldValue = false,
]) {
  if (approveListDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(approveListDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(approveListDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getApproveListDataModelListFirestoreData(
  List<ApproveListDataModelStruct>? approveListDataModels,
) =>
    approveListDataModels
        ?.map((e) => getApproveListDataModelFirestoreData(e, true))
        .toList() ??
    [];
