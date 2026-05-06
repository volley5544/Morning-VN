// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LeavePeriodStruct extends FFFirebaseStruct {
  LeavePeriodStruct({
    String? key,
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _key = key,
        _name = name,
        super(firestoreUtilData);

  // "key" field.
  String? _key;
  String get key => _key ?? '';
  set key(String? val) => _key = val;

  bool hasKey() => _key != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static LeavePeriodStruct fromMap(Map<String, dynamic> data) =>
      LeavePeriodStruct(
        key: data['key'] as String?,
        name: data['name'] as String?,
      );

  static LeavePeriodStruct? maybeFromMap(dynamic data) => data is Map
      ? LeavePeriodStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'key': _key,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'key': serializeParam(
          _key,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static LeavePeriodStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeavePeriodStruct(
        key: deserializeParam(
          data['key'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LeavePeriodStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LeavePeriodStruct && key == other.key && name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([key, name]);
}

LeavePeriodStruct createLeavePeriodStruct({
  String? key,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeavePeriodStruct(
      key: key,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeavePeriodStruct? updateLeavePeriodStruct(
  LeavePeriodStruct? leavePeriod, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leavePeriod
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeavePeriodStructData(
  Map<String, dynamic> firestoreData,
  LeavePeriodStruct? leavePeriod,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leavePeriod == null) {
    return;
  }
  if (leavePeriod.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leavePeriod.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leavePeriodData =
      getLeavePeriodFirestoreData(leavePeriod, forFieldValue);
  final nestedData =
      leavePeriodData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leavePeriod.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeavePeriodFirestoreData(
  LeavePeriodStruct? leavePeriod, [
  bool forFieldValue = false,
]) {
  if (leavePeriod == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leavePeriod.toMap());

  // Add any Firestore field values
  mapToFirestore(leavePeriod.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeavePeriodListFirestoreData(
  List<LeavePeriodStruct>? leavePeriods,
) =>
    leavePeriods?.map((e) => getLeavePeriodFirestoreData(e, true)).toList() ??
    [];
