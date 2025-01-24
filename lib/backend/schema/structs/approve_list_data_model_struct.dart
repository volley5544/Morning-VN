// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApproveListDataModelStruct extends FFFirebaseStruct {
  ApproveListDataModelStruct({
    int? year,
    ApproveListMonthDataModelStruct? cancel,
    ApproveListMonthDataModelStruct? approve,
    ApproveListMonthDataModelStruct? notApprove,
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
  ApproveListMonthDataModelStruct? _cancel;
  ApproveListMonthDataModelStruct get cancel =>
      _cancel ?? ApproveListMonthDataModelStruct();
  set cancel(ApproveListMonthDataModelStruct? val) => _cancel = val;

  void updateCancel(Function(ApproveListMonthDataModelStruct) updateFn) {
    updateFn(_cancel ??= ApproveListMonthDataModelStruct());
  }

  bool hasCancel() => _cancel != null;

  // "Approve" field.
  ApproveListMonthDataModelStruct? _approve;
  ApproveListMonthDataModelStruct get approve =>
      _approve ?? ApproveListMonthDataModelStruct();
  set approve(ApproveListMonthDataModelStruct? val) => _approve = val;

  void updateApprove(Function(ApproveListMonthDataModelStruct) updateFn) {
    updateFn(_approve ??= ApproveListMonthDataModelStruct());
  }

  bool hasApprove() => _approve != null;

  // "NotApprove" field.
  ApproveListMonthDataModelStruct? _notApprove;
  ApproveListMonthDataModelStruct get notApprove =>
      _notApprove ?? ApproveListMonthDataModelStruct();
  set notApprove(ApproveListMonthDataModelStruct? val) => _notApprove = val;

  void updateNotApprove(Function(ApproveListMonthDataModelStruct) updateFn) {
    updateFn(_notApprove ??= ApproveListMonthDataModelStruct());
  }

  bool hasNotApprove() => _notApprove != null;

  static ApproveListDataModelStruct fromMap(Map<String, dynamic> data) =>
      ApproveListDataModelStruct(
        year: castToType<int>(data['year']),
        cancel: data['Cancel'] is ApproveListMonthDataModelStruct
            ? data['Cancel']
            : ApproveListMonthDataModelStruct.maybeFromMap(data['Cancel']),
        approve: data['Approve'] is ApproveListMonthDataModelStruct
            ? data['Approve']
            : ApproveListMonthDataModelStruct.maybeFromMap(data['Approve']),
        notApprove: data['NotApprove'] is ApproveListMonthDataModelStruct
            ? data['NotApprove']
            : ApproveListMonthDataModelStruct.maybeFromMap(data['NotApprove']),
      );

  static ApproveListDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? ApproveListDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'year': _year,
        'Cancel': _cancel?.toMap(),
        'Approve': _approve?.toMap(),
        'NotApprove': _notApprove?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'year': serializeParam(
          _year,
          ParamType.int,
        ),
        'Cancel': serializeParam(
          _cancel,
          ParamType.DataStruct,
        ),
        'Approve': serializeParam(
          _approve,
          ParamType.DataStruct,
        ),
        'NotApprove': serializeParam(
          _notApprove,
          ParamType.DataStruct,
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
        cancel: deserializeStructParam(
          data['Cancel'],
          ParamType.DataStruct,
          false,
          structBuilder: ApproveListMonthDataModelStruct.fromSerializableMap,
        ),
        approve: deserializeStructParam(
          data['Approve'],
          ParamType.DataStruct,
          false,
          structBuilder: ApproveListMonthDataModelStruct.fromSerializableMap,
        ),
        notApprove: deserializeStructParam(
          data['NotApprove'],
          ParamType.DataStruct,
          false,
          structBuilder: ApproveListMonthDataModelStruct.fromSerializableMap,
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
  ApproveListMonthDataModelStruct? cancel,
  ApproveListMonthDataModelStruct? approve,
  ApproveListMonthDataModelStruct? notApprove,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ApproveListDataModelStruct(
      year: year,
      cancel: cancel ??
          (clearUnsetFields ? ApproveListMonthDataModelStruct() : null),
      approve: approve ??
          (clearUnsetFields ? ApproveListMonthDataModelStruct() : null),
      notApprove: notApprove ??
          (clearUnsetFields ? ApproveListMonthDataModelStruct() : null),
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

  // Handle nested data for "Cancel" field.
  addApproveListMonthDataModelStructData(
    firestoreData,
    approveListDataModel.hasCancel() ? approveListDataModel.cancel : null,
    'Cancel',
    forFieldValue,
  );

  // Handle nested data for "Approve" field.
  addApproveListMonthDataModelStructData(
    firestoreData,
    approveListDataModel.hasApprove() ? approveListDataModel.approve : null,
    'Approve',
    forFieldValue,
  );

  // Handle nested data for "NotApprove" field.
  addApproveListMonthDataModelStructData(
    firestoreData,
    approveListDataModel.hasNotApprove()
        ? approveListDataModel.notApprove
        : null,
    'NotApprove',
    forFieldValue,
  );

  // Add any Firestore field values
  approveListDataModel.firestoreUtilData.fieldValues
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
