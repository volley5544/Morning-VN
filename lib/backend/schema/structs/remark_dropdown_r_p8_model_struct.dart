// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RemarkDropdownRP8ModelStruct extends FFFirebaseStruct {
  RemarkDropdownRP8ModelStruct({
    int? id,
    String? code,
    String? description,
    String? isActive,
    String? groupCollectionCode,
    String? collectionCode,
    String? collectionDescription,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _code = code,
        _description = description,
        _isActive = isActive,
        _groupCollectionCode = groupCollectionCode,
        _collectionCode = collectionCode,
        _collectionDescription = collectionDescription,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;

  bool hasCode() => _code != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "is_active" field.
  String? _isActive;
  String get isActive => _isActive ?? '';
  set isActive(String? val) => _isActive = val;

  bool hasIsActive() => _isActive != null;

  // "group_collection_code" field.
  String? _groupCollectionCode;
  String get groupCollectionCode => _groupCollectionCode ?? '';
  set groupCollectionCode(String? val) => _groupCollectionCode = val;

  bool hasGroupCollectionCode() => _groupCollectionCode != null;

  // "collection_code" field.
  String? _collectionCode;
  String get collectionCode => _collectionCode ?? '';
  set collectionCode(String? val) => _collectionCode = val;

  bool hasCollectionCode() => _collectionCode != null;

  // "collection_description" field.
  String? _collectionDescription;
  String get collectionDescription => _collectionDescription ?? '';
  set collectionDescription(String? val) => _collectionDescription = val;

  bool hasCollectionDescription() => _collectionDescription != null;

  static RemarkDropdownRP8ModelStruct fromMap(Map<String, dynamic> data) =>
      RemarkDropdownRP8ModelStruct(
        id: castToType<int>(data['id']),
        code: data['code'] as String?,
        description: data['description'] as String?,
        isActive: data['is_active'] as String?,
        groupCollectionCode: data['group_collection_code'] as String?,
        collectionCode: data['collection_code'] as String?,
        collectionDescription: data['collection_description'] as String?,
      );

  static RemarkDropdownRP8ModelStruct? maybeFromMap(dynamic data) => data is Map
      ? RemarkDropdownRP8ModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'code': _code,
        'description': _description,
        'is_active': _isActive,
        'group_collection_code': _groupCollectionCode,
        'collection_code': _collectionCode,
        'collection_description': _collectionDescription,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'code': serializeParam(
          _code,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'is_active': serializeParam(
          _isActive,
          ParamType.String,
        ),
        'group_collection_code': serializeParam(
          _groupCollectionCode,
          ParamType.String,
        ),
        'collection_code': serializeParam(
          _collectionCode,
          ParamType.String,
        ),
        'collection_description': serializeParam(
          _collectionDescription,
          ParamType.String,
        ),
      }.withoutNulls;

  static RemarkDropdownRP8ModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RemarkDropdownRP8ModelStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        code: deserializeParam(
          data['code'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        isActive: deserializeParam(
          data['is_active'],
          ParamType.String,
          false,
        ),
        groupCollectionCode: deserializeParam(
          data['group_collection_code'],
          ParamType.String,
          false,
        ),
        collectionCode: deserializeParam(
          data['collection_code'],
          ParamType.String,
          false,
        ),
        collectionDescription: deserializeParam(
          data['collection_description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RemarkDropdownRP8ModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RemarkDropdownRP8ModelStruct &&
        id == other.id &&
        code == other.code &&
        description == other.description &&
        isActive == other.isActive &&
        groupCollectionCode == other.groupCollectionCode &&
        collectionCode == other.collectionCode &&
        collectionDescription == other.collectionDescription;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        code,
        description,
        isActive,
        groupCollectionCode,
        collectionCode,
        collectionDescription
      ]);
}

RemarkDropdownRP8ModelStruct createRemarkDropdownRP8ModelStruct({
  int? id,
  String? code,
  String? description,
  String? isActive,
  String? groupCollectionCode,
  String? collectionCode,
  String? collectionDescription,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RemarkDropdownRP8ModelStruct(
      id: id,
      code: code,
      description: description,
      isActive: isActive,
      groupCollectionCode: groupCollectionCode,
      collectionCode: collectionCode,
      collectionDescription: collectionDescription,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RemarkDropdownRP8ModelStruct? updateRemarkDropdownRP8ModelStruct(
  RemarkDropdownRP8ModelStruct? remarkDropdownRP8Model, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    remarkDropdownRP8Model
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRemarkDropdownRP8ModelStructData(
  Map<String, dynamic> firestoreData,
  RemarkDropdownRP8ModelStruct? remarkDropdownRP8Model,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (remarkDropdownRP8Model == null) {
    return;
  }
  if (remarkDropdownRP8Model.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      remarkDropdownRP8Model.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final remarkDropdownRP8ModelData = getRemarkDropdownRP8ModelFirestoreData(
      remarkDropdownRP8Model, forFieldValue);
  final nestedData =
      remarkDropdownRP8ModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      remarkDropdownRP8Model.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRemarkDropdownRP8ModelFirestoreData(
  RemarkDropdownRP8ModelStruct? remarkDropdownRP8Model, [
  bool forFieldValue = false,
]) {
  if (remarkDropdownRP8Model == null) {
    return {};
  }
  final firestoreData = mapToFirestore(remarkDropdownRP8Model.toMap());

  // Add any Firestore field values
  mapToFirestore(remarkDropdownRP8Model.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRemarkDropdownRP8ModelListFirestoreData(
  List<RemarkDropdownRP8ModelStruct>? remarkDropdownRP8Models,
) =>
    remarkDropdownRP8Models
        ?.map((e) => getRemarkDropdownRP8ModelFirestoreData(e, true))
        .toList() ??
    [];
