// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ListLocationCheckInStruct extends FFFirebaseStruct {
  ListLocationCheckInStruct({
    String? branchCode,
    String? branchName,
    String? latitude,
    String? longitude,
    String? radius,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _branchCode = branchCode,
        _branchName = branchName,
        _latitude = latitude,
        _longitude = longitude,
        _radius = radius,
        super(firestoreUtilData);

  // "BRANCH_CODE" field.
  String? _branchCode;
  String get branchCode => _branchCode ?? '';
  set branchCode(String? val) => _branchCode = val;

  bool hasBranchCode() => _branchCode != null;

  // "BRANCH_NAME" field.
  String? _branchName;
  String get branchName => _branchName ?? '';
  set branchName(String? val) => _branchName = val;

  bool hasBranchName() => _branchName != null;

  // "LATITUDE" field.
  String? _latitude;
  String get latitude => _latitude ?? '';
  set latitude(String? val) => _latitude = val;

  bool hasLatitude() => _latitude != null;

  // "LONGITUDE" field.
  String? _longitude;
  String get longitude => _longitude ?? '';
  set longitude(String? val) => _longitude = val;

  bool hasLongitude() => _longitude != null;

  // "RADIUS" field.
  String? _radius;
  String get radius => _radius ?? '';
  set radius(String? val) => _radius = val;

  bool hasRadius() => _radius != null;

  static ListLocationCheckInStruct fromMap(Map<String, dynamic> data) =>
      ListLocationCheckInStruct(
        branchCode: data['BRANCH_CODE'] as String?,
        branchName: data['BRANCH_NAME'] as String?,
        latitude: data['LATITUDE'] as String?,
        longitude: data['LONGITUDE'] as String?,
        radius: data['RADIUS'] as String?,
      );

  static ListLocationCheckInStruct? maybeFromMap(dynamic data) => data is Map
      ? ListLocationCheckInStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'BRANCH_CODE': _branchCode,
        'BRANCH_NAME': _branchName,
        'LATITUDE': _latitude,
        'LONGITUDE': _longitude,
        'RADIUS': _radius,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'BRANCH_CODE': serializeParam(
          _branchCode,
          ParamType.String,
        ),
        'BRANCH_NAME': serializeParam(
          _branchName,
          ParamType.String,
        ),
        'LATITUDE': serializeParam(
          _latitude,
          ParamType.String,
        ),
        'LONGITUDE': serializeParam(
          _longitude,
          ParamType.String,
        ),
        'RADIUS': serializeParam(
          _radius,
          ParamType.String,
        ),
      }.withoutNulls;

  static ListLocationCheckInStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ListLocationCheckInStruct(
        branchCode: deserializeParam(
          data['BRANCH_CODE'],
          ParamType.String,
          false,
        ),
        branchName: deserializeParam(
          data['BRANCH_NAME'],
          ParamType.String,
          false,
        ),
        latitude: deserializeParam(
          data['LATITUDE'],
          ParamType.String,
          false,
        ),
        longitude: deserializeParam(
          data['LONGITUDE'],
          ParamType.String,
          false,
        ),
        radius: deserializeParam(
          data['RADIUS'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ListLocationCheckInStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ListLocationCheckInStruct &&
        branchCode == other.branchCode &&
        branchName == other.branchName &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        radius == other.radius;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([branchCode, branchName, latitude, longitude, radius]);
}

ListLocationCheckInStruct createListLocationCheckInStruct({
  String? branchCode,
  String? branchName,
  String? latitude,
  String? longitude,
  String? radius,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListLocationCheckInStruct(
      branchCode: branchCode,
      branchName: branchName,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListLocationCheckInStruct? updateListLocationCheckInStruct(
  ListLocationCheckInStruct? listLocationCheckIn, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listLocationCheckIn
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListLocationCheckInStructData(
  Map<String, dynamic> firestoreData,
  ListLocationCheckInStruct? listLocationCheckIn,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listLocationCheckIn == null) {
    return;
  }
  if (listLocationCheckIn.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listLocationCheckIn.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listLocationCheckInData =
      getListLocationCheckInFirestoreData(listLocationCheckIn, forFieldValue);
  final nestedData =
      listLocationCheckInData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      listLocationCheckIn.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListLocationCheckInFirestoreData(
  ListLocationCheckInStruct? listLocationCheckIn, [
  bool forFieldValue = false,
]) {
  if (listLocationCheckIn == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listLocationCheckIn.toMap());

  // Add any Firestore field values
  mapToFirestore(listLocationCheckIn.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListLocationCheckInListFirestoreData(
  List<ListLocationCheckInStruct>? listLocationCheckIns,
) =>
    listLocationCheckIns
        ?.map((e) => getListLocationCheckInFirestoreData(e, true))
        .toList() ??
    [];
