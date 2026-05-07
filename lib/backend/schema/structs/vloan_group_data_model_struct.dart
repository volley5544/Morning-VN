// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class VloanGroupDataModelStruct extends FFFirebaseStruct {
  VloanGroupDataModelStruct({
    String? remgcode,
    String? remdesc,
    String? remdetcode,
    String? remdetdesc,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _remgcode = remgcode,
        _remdesc = remdesc,
        _remdetcode = remdetcode,
        _remdetdesc = remdetdesc,
        super(firestoreUtilData);

  // "REMGCODE" field.
  String? _remgcode;
  String get remgcode => _remgcode ?? '';
  set remgcode(String? val) => _remgcode = val;

  bool hasRemgcode() => _remgcode != null;

  // "REMDESC" field.
  String? _remdesc;
  String get remdesc => _remdesc ?? '';
  set remdesc(String? val) => _remdesc = val;

  bool hasRemdesc() => _remdesc != null;

  // "REMDETCODE" field.
  String? _remdetcode;
  String get remdetcode => _remdetcode ?? '';
  set remdetcode(String? val) => _remdetcode = val;

  bool hasRemdetcode() => _remdetcode != null;

  // "REMDETDESC" field.
  String? _remdetdesc;
  String get remdetdesc => _remdetdesc ?? '';
  set remdetdesc(String? val) => _remdetdesc = val;

  bool hasRemdetdesc() => _remdetdesc != null;

  static VloanGroupDataModelStruct fromMap(Map<String, dynamic> data) =>
      VloanGroupDataModelStruct(
        remgcode: data['REMGCODE'] as String?,
        remdesc: data['REMDESC'] as String?,
        remdetcode: data['REMDETCODE'] as String?,
        remdetdesc: data['REMDETDESC'] as String?,
      );

  static VloanGroupDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? VloanGroupDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'REMGCODE': _remgcode,
        'REMDESC': _remdesc,
        'REMDETCODE': _remdetcode,
        'REMDETDESC': _remdetdesc,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'REMGCODE': serializeParam(
          _remgcode,
          ParamType.String,
        ),
        'REMDESC': serializeParam(
          _remdesc,
          ParamType.String,
        ),
        'REMDETCODE': serializeParam(
          _remdetcode,
          ParamType.String,
        ),
        'REMDETDESC': serializeParam(
          _remdetdesc,
          ParamType.String,
        ),
      }.withoutNulls;

  static VloanGroupDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      VloanGroupDataModelStruct(
        remgcode: deserializeParam(
          data['REMGCODE'],
          ParamType.String,
          false,
        ),
        remdesc: deserializeParam(
          data['REMDESC'],
          ParamType.String,
          false,
        ),
        remdetcode: deserializeParam(
          data['REMDETCODE'],
          ParamType.String,
          false,
        ),
        remdetdesc: deserializeParam(
          data['REMDETDESC'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VloanGroupDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VloanGroupDataModelStruct &&
        remgcode == other.remgcode &&
        remdesc == other.remdesc &&
        remdetcode == other.remdetcode &&
        remdetdesc == other.remdetdesc;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([remgcode, remdesc, remdetcode, remdetdesc]);
}

VloanGroupDataModelStruct createVloanGroupDataModelStruct({
  String? remgcode,
  String? remdesc,
  String? remdetcode,
  String? remdetdesc,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VloanGroupDataModelStruct(
      remgcode: remgcode,
      remdesc: remdesc,
      remdetcode: remdetcode,
      remdetdesc: remdetdesc,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VloanGroupDataModelStruct? updateVloanGroupDataModelStruct(
  VloanGroupDataModelStruct? vloanGroupDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    vloanGroupDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVloanGroupDataModelStructData(
  Map<String, dynamic> firestoreData,
  VloanGroupDataModelStruct? vloanGroupDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (vloanGroupDataModel == null) {
    return;
  }
  if (vloanGroupDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && vloanGroupDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final vloanGroupDataModelData =
      getVloanGroupDataModelFirestoreData(vloanGroupDataModel, forFieldValue);
  final nestedData =
      vloanGroupDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      vloanGroupDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVloanGroupDataModelFirestoreData(
  VloanGroupDataModelStruct? vloanGroupDataModel, [
  bool forFieldValue = false,
]) {
  if (vloanGroupDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(vloanGroupDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(vloanGroupDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVloanGroupDataModelListFirestoreData(
  List<VloanGroupDataModelStruct>? vloanGroupDataModels,
) =>
    vloanGroupDataModels
        ?.map((e) => getVloanGroupDataModelFirestoreData(e, true))
        .toList() ??
    [];
