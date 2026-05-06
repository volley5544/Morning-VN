// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DataStruct extends FFFirebaseStruct {
  DataStruct({
    String? dateTime,
    String? employeeId,
    String? latitude,
    String? longitude,
    String? eTLCreateDate,
    String? times,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _dateTime = dateTime,
        _employeeId = employeeId,
        _latitude = latitude,
        _longitude = longitude,
        _eTLCreateDate = eTLCreateDate,
        _times = times,
        super(firestoreUtilData);

  // "date_time" field.
  String? _dateTime;
  String get dateTime => _dateTime ?? '';
  set dateTime(String? val) => _dateTime = val;

  bool hasDateTime() => _dateTime != null;

  // "employee_id" field.
  String? _employeeId;
  String get employeeId => _employeeId ?? '';
  set employeeId(String? val) => _employeeId = val;

  bool hasEmployeeId() => _employeeId != null;

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

  // "ETLCreateDate" field.
  String? _eTLCreateDate;
  String get eTLCreateDate => _eTLCreateDate ?? '';
  set eTLCreateDate(String? val) => _eTLCreateDate = val;

  bool hasETLCreateDate() => _eTLCreateDate != null;

  // "times" field.
  String? _times;
  String get times => _times ?? '';
  set times(String? val) => _times = val;

  bool hasTimes() => _times != null;

  static DataStruct fromMap(Map<String, dynamic> data) => DataStruct(
        dateTime: data['date_time'] as String?,
        employeeId: data['employee_id'] as String?,
        latitude: data['latitude'] as String?,
        longitude: data['longitude'] as String?,
        eTLCreateDate: data['ETLCreateDate'] as String?,
        times: data['times'] as String?,
      );

  static DataStruct? maybeFromMap(dynamic data) =>
      data is Map ? DataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'date_time': _dateTime,
        'employee_id': _employeeId,
        'latitude': _latitude,
        'longitude': _longitude,
        'ETLCreateDate': _eTLCreateDate,
        'times': _times,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date_time': serializeParam(
          _dateTime,
          ParamType.String,
        ),
        'employee_id': serializeParam(
          _employeeId,
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
        'ETLCreateDate': serializeParam(
          _eTLCreateDate,
          ParamType.String,
        ),
        'times': serializeParam(
          _times,
          ParamType.String,
        ),
      }.withoutNulls;

  static DataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataStruct(
        dateTime: deserializeParam(
          data['date_time'],
          ParamType.String,
          false,
        ),
        employeeId: deserializeParam(
          data['employee_id'],
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
        eTLCreateDate: deserializeParam(
          data['ETLCreateDate'],
          ParamType.String,
          false,
        ),
        times: deserializeParam(
          data['times'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataStruct &&
        dateTime == other.dateTime &&
        employeeId == other.employeeId &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        eTLCreateDate == other.eTLCreateDate &&
        times == other.times;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([dateTime, employeeId, latitude, longitude, eTLCreateDate, times]);
}

DataStruct createDataStruct({
  String? dateTime,
  String? employeeId,
  String? latitude,
  String? longitude,
  String? eTLCreateDate,
  String? times,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataStruct(
      dateTime: dateTime,
      employeeId: employeeId,
      latitude: latitude,
      longitude: longitude,
      eTLCreateDate: eTLCreateDate,
      times: times,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataStruct? updateDataStruct(
  DataStruct? data, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    data
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataStructData(
  Map<String, dynamic> firestoreData,
  DataStruct? data,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (data == null) {
    return;
  }
  if (data.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && data.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dataData = getDataFirestoreData(data, forFieldValue);
  final nestedData = dataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = data.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataFirestoreData(
  DataStruct? data, [
  bool forFieldValue = false,
]) {
  if (data == null) {
    return {};
  }
  final firestoreData = mapToFirestore(data.toMap());

  // Add any Firestore field values
  mapToFirestore(data.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDataListFirestoreData(
  List<DataStruct>? datas,
) =>
    datas?.map((e) => getDataFirestoreData(e, true)).toList() ?? [];
