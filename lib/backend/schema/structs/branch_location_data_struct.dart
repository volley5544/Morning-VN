// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BranchLocationDataStruct extends FFFirebaseStruct {
  BranchLocationDataStruct({
    String? branchCode,
    String? branchName,
    String? groupCode,
    String? areaCode,
    String? regionCode,
    String? latitude,
    String? longitude,
    String? radius,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _branchCode = branchCode,
        _branchName = branchName,
        _groupCode = groupCode,
        _areaCode = areaCode,
        _regionCode = regionCode,
        _latitude = latitude,
        _longitude = longitude,
        _radius = radius,
        super(firestoreUtilData);

  // "branch_code" field.
  String? _branchCode;
  String get branchCode => _branchCode ?? '';
  set branchCode(String? val) => _branchCode = val;

  bool hasBranchCode() => _branchCode != null;

  // "branch_name" field.
  String? _branchName;
  String get branchName => _branchName ?? '';
  set branchName(String? val) => _branchName = val;

  bool hasBranchName() => _branchName != null;

  // "group_code" field.
  String? _groupCode;
  String get groupCode => _groupCode ?? '';
  set groupCode(String? val) => _groupCode = val;

  bool hasGroupCode() => _groupCode != null;

  // "area_code" field.
  String? _areaCode;
  String get areaCode => _areaCode ?? '';
  set areaCode(String? val) => _areaCode = val;

  bool hasAreaCode() => _areaCode != null;

  // "region_code" field.
  String? _regionCode;
  String get regionCode => _regionCode ?? '';
  set regionCode(String? val) => _regionCode = val;

  bool hasRegionCode() => _regionCode != null;

  // "latitude" field.
  String? _latitude;
  String get latitude => _latitude ?? '';
  set latitude(String? val) => _latitude = val;

  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  String? _longitude;
  String get longitude => _longitude ?? '';
  set longitude(String? val) => _longitude = val;

  bool hasLongitude() => _longitude != null;

  // "radius" field.
  String? _radius;
  String get radius => _radius ?? '';
  set radius(String? val) => _radius = val;

  bool hasRadius() => _radius != null;

  static BranchLocationDataStruct fromMap(Map<String, dynamic> data) =>
      BranchLocationDataStruct(
        branchCode: data['branch_code'] as String?,
        branchName: data['branch_name'] as String?,
        groupCode: data['group_code'] as String?,
        areaCode: data['area_code'] as String?,
        regionCode: data['region_code'] as String?,
        latitude: data['latitude'] as String?,
        longitude: data['longitude'] as String?,
        radius: data['radius'] as String?,
      );

  static BranchLocationDataStruct? maybeFromMap(dynamic data) => data is Map
      ? BranchLocationDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'branch_code': _branchCode,
        'branch_name': _branchName,
        'group_code': _groupCode,
        'area_code': _areaCode,
        'region_code': _regionCode,
        'latitude': _latitude,
        'longitude': _longitude,
        'radius': _radius,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'branch_code': serializeParam(
          _branchCode,
          ParamType.String,
        ),
        'branch_name': serializeParam(
          _branchName,
          ParamType.String,
        ),
        'group_code': serializeParam(
          _groupCode,
          ParamType.String,
        ),
        'area_code': serializeParam(
          _areaCode,
          ParamType.String,
        ),
        'region_code': serializeParam(
          _regionCode,
          ParamType.String,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.String,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.String,
        ),
        'radius': serializeParam(
          _radius,
          ParamType.String,
        ),
      }.withoutNulls;

  static BranchLocationDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BranchLocationDataStruct(
        branchCode: deserializeParam(
          data['branch_code'],
          ParamType.String,
          false,
        ),
        branchName: deserializeParam(
          data['branch_name'],
          ParamType.String,
          false,
        ),
        groupCode: deserializeParam(
          data['group_code'],
          ParamType.String,
          false,
        ),
        areaCode: deserializeParam(
          data['area_code'],
          ParamType.String,
          false,
        ),
        regionCode: deserializeParam(
          data['region_code'],
          ParamType.String,
          false,
        ),
        latitude: deserializeParam(
          data['latitude'],
          ParamType.String,
          false,
        ),
        longitude: deserializeParam(
          data['longitude'],
          ParamType.String,
          false,
        ),
        radius: deserializeParam(
          data['radius'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BranchLocationDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BranchLocationDataStruct &&
        branchCode == other.branchCode &&
        branchName == other.branchName &&
        groupCode == other.groupCode &&
        areaCode == other.areaCode &&
        regionCode == other.regionCode &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        radius == other.radius;
  }

  @override
  int get hashCode => const ListEquality().hash([
        branchCode,
        branchName,
        groupCode,
        areaCode,
        regionCode,
        latitude,
        longitude,
        radius
      ]);
}

BranchLocationDataStruct createBranchLocationDataStruct({
  String? branchCode,
  String? branchName,
  String? groupCode,
  String? areaCode,
  String? regionCode,
  String? latitude,
  String? longitude,
  String? radius,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BranchLocationDataStruct(
      branchCode: branchCode,
      branchName: branchName,
      groupCode: groupCode,
      areaCode: areaCode,
      regionCode: regionCode,
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

BranchLocationDataStruct? updateBranchLocationDataStruct(
  BranchLocationDataStruct? branchLocationData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    branchLocationData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBranchLocationDataStructData(
  Map<String, dynamic> firestoreData,
  BranchLocationDataStruct? branchLocationData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (branchLocationData == null) {
    return;
  }
  if (branchLocationData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && branchLocationData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final branchLocationDataData =
      getBranchLocationDataFirestoreData(branchLocationData, forFieldValue);
  final nestedData =
      branchLocationDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      branchLocationData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBranchLocationDataFirestoreData(
  BranchLocationDataStruct? branchLocationData, [
  bool forFieldValue = false,
]) {
  if (branchLocationData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(branchLocationData.toMap());

  // Add any Firestore field values
  branchLocationData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBranchLocationDataListFirestoreData(
  List<BranchLocationDataStruct>? branchLocationDatas,
) =>
    branchLocationDatas
        ?.map((e) => getBranchLocationDataFirestoreData(e, true))
        .toList() ??
    [];
