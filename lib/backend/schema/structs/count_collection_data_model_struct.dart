// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CountCollectionDataModelStruct extends FFFirebaseStruct {
  CountCollectionDataModelStruct({
    String? dataTab,
    String? count,
    String? dataTabKey,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _dataTab = dataTab,
        _count = count,
        _dataTabKey = dataTabKey,
        super(firestoreUtilData);

  // "dataTab" field.
  String? _dataTab;
  String get dataTab => _dataTab ?? '';
  set dataTab(String? val) => _dataTab = val;

  bool hasDataTab() => _dataTab != null;

  // "Count" field.
  String? _count;
  String get count => _count ?? '';
  set count(String? val) => _count = val;

  bool hasCount() => _count != null;

  // "dataTabKey" field.
  String? _dataTabKey;
  String get dataTabKey => _dataTabKey ?? '';
  set dataTabKey(String? val) => _dataTabKey = val;

  bool hasDataTabKey() => _dataTabKey != null;

  static CountCollectionDataModelStruct fromMap(Map<String, dynamic> data) =>
      CountCollectionDataModelStruct(
        dataTab: data['dataTab'] as String?,
        count: data['Count'] as String?,
        dataTabKey: data['dataTabKey'] as String?,
      );

  static CountCollectionDataModelStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? CountCollectionDataModelStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'dataTab': _dataTab,
        'Count': _count,
        'dataTabKey': _dataTabKey,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'dataTab': serializeParam(
          _dataTab,
          ParamType.String,
        ),
        'Count': serializeParam(
          _count,
          ParamType.String,
        ),
        'dataTabKey': serializeParam(
          _dataTabKey,
          ParamType.String,
        ),
      }.withoutNulls;

  static CountCollectionDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CountCollectionDataModelStruct(
        dataTab: deserializeParam(
          data['dataTab'],
          ParamType.String,
          false,
        ),
        count: deserializeParam(
          data['Count'],
          ParamType.String,
          false,
        ),
        dataTabKey: deserializeParam(
          data['dataTabKey'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CountCollectionDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CountCollectionDataModelStruct &&
        dataTab == other.dataTab &&
        count == other.count &&
        dataTabKey == other.dataTabKey;
  }

  @override
  int get hashCode => const ListEquality().hash([dataTab, count, dataTabKey]);
}

CountCollectionDataModelStruct createCountCollectionDataModelStruct({
  String? dataTab,
  String? count,
  String? dataTabKey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CountCollectionDataModelStruct(
      dataTab: dataTab,
      count: count,
      dataTabKey: dataTabKey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CountCollectionDataModelStruct? updateCountCollectionDataModelStruct(
  CountCollectionDataModelStruct? countCollectionDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    countCollectionDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCountCollectionDataModelStructData(
  Map<String, dynamic> firestoreData,
  CountCollectionDataModelStruct? countCollectionDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (countCollectionDataModel == null) {
    return;
  }
  if (countCollectionDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      countCollectionDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final countCollectionDataModelData = getCountCollectionDataModelFirestoreData(
      countCollectionDataModel, forFieldValue);
  final nestedData =
      countCollectionDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      countCollectionDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCountCollectionDataModelFirestoreData(
  CountCollectionDataModelStruct? countCollectionDataModel, [
  bool forFieldValue = false,
]) {
  if (countCollectionDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(countCollectionDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(countCollectionDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCountCollectionDataModelListFirestoreData(
  List<CountCollectionDataModelStruct>? countCollectionDataModels,
) =>
    countCollectionDataModels
        ?.map((e) => getCountCollectionDataModelFirestoreData(e, true))
        .toList() ??
    [];
