// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TrackingEmployeeDataModelStruct extends FFFirebaseStruct {
  TrackingEmployeeDataModelStruct({
    String? nameTh,
    String? employeeId,
    String? branchCode,
    String? position,
    String? level,
    String? status,
    String? fullprofile,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nameTh = nameTh,
        _employeeId = employeeId,
        _branchCode = branchCode,
        _position = position,
        _level = level,
        _status = status,
        _fullprofile = fullprofile,
        super(firestoreUtilData);

  // "name_th" field.
  String? _nameTh;
  String get nameTh => _nameTh ?? '';
  set nameTh(String? val) => _nameTh = val;

  bool hasNameTh() => _nameTh != null;

  // "employee_id" field.
  String? _employeeId;
  String get employeeId => _employeeId ?? '';
  set employeeId(String? val) => _employeeId = val;

  bool hasEmployeeId() => _employeeId != null;

  // "branch_code" field.
  String? _branchCode;
  String get branchCode => _branchCode ?? '';
  set branchCode(String? val) => _branchCode = val;

  bool hasBranchCode() => _branchCode != null;

  // "position" field.
  String? _position;
  String get position => _position ?? '';
  set position(String? val) => _position = val;

  bool hasPosition() => _position != null;

  // "level" field.
  String? _level;
  String get level => _level ?? '';
  set level(String? val) => _level = val;

  bool hasLevel() => _level != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "fullprofile" field.
  String? _fullprofile;
  String get fullprofile => _fullprofile ?? '';
  set fullprofile(String? val) => _fullprofile = val;

  bool hasFullprofile() => _fullprofile != null;

  static TrackingEmployeeDataModelStruct fromMap(Map<String, dynamic> data) =>
      TrackingEmployeeDataModelStruct(
        nameTh: data['name_th'] as String?,
        employeeId: data['employee_id'] as String?,
        branchCode: data['branch_code'] as String?,
        position: data['position'] as String?,
        level: data['level'] as String?,
        status: data['status'] as String?,
        fullprofile: data['fullprofile'] as String?,
      );

  static TrackingEmployeeDataModelStruct? maybeFromMap(dynamic data) => data
          is Map
      ? TrackingEmployeeDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name_th': _nameTh,
        'employee_id': _employeeId,
        'branch_code': _branchCode,
        'position': _position,
        'level': _level,
        'status': _status,
        'fullprofile': _fullprofile,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name_th': serializeParam(
          _nameTh,
          ParamType.String,
        ),
        'employee_id': serializeParam(
          _employeeId,
          ParamType.String,
        ),
        'branch_code': serializeParam(
          _branchCode,
          ParamType.String,
        ),
        'position': serializeParam(
          _position,
          ParamType.String,
        ),
        'level': serializeParam(
          _level,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'fullprofile': serializeParam(
          _fullprofile,
          ParamType.String,
        ),
      }.withoutNulls;

  static TrackingEmployeeDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TrackingEmployeeDataModelStruct(
        nameTh: deserializeParam(
          data['name_th'],
          ParamType.String,
          false,
        ),
        employeeId: deserializeParam(
          data['employee_id'],
          ParamType.String,
          false,
        ),
        branchCode: deserializeParam(
          data['branch_code'],
          ParamType.String,
          false,
        ),
        position: deserializeParam(
          data['position'],
          ParamType.String,
          false,
        ),
        level: deserializeParam(
          data['level'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        fullprofile: deserializeParam(
          data['fullprofile'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TrackingEmployeeDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrackingEmployeeDataModelStruct &&
        nameTh == other.nameTh &&
        employeeId == other.employeeId &&
        branchCode == other.branchCode &&
        position == other.position &&
        level == other.level &&
        status == other.status &&
        fullprofile == other.fullprofile;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [nameTh, employeeId, branchCode, position, level, status, fullprofile]);
}

TrackingEmployeeDataModelStruct createTrackingEmployeeDataModelStruct({
  String? nameTh,
  String? employeeId,
  String? branchCode,
  String? position,
  String? level,
  String? status,
  String? fullprofile,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TrackingEmployeeDataModelStruct(
      nameTh: nameTh,
      employeeId: employeeId,
      branchCode: branchCode,
      position: position,
      level: level,
      status: status,
      fullprofile: fullprofile,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TrackingEmployeeDataModelStruct? updateTrackingEmployeeDataModelStruct(
  TrackingEmployeeDataModelStruct? trackingEmployeeDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    trackingEmployeeDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTrackingEmployeeDataModelStructData(
  Map<String, dynamic> firestoreData,
  TrackingEmployeeDataModelStruct? trackingEmployeeDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (trackingEmployeeDataModel == null) {
    return;
  }
  if (trackingEmployeeDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      trackingEmployeeDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final trackingEmployeeDataModelData =
      getTrackingEmployeeDataModelFirestoreData(
          trackingEmployeeDataModel, forFieldValue);
  final nestedData =
      trackingEmployeeDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      trackingEmployeeDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTrackingEmployeeDataModelFirestoreData(
  TrackingEmployeeDataModelStruct? trackingEmployeeDataModel, [
  bool forFieldValue = false,
]) {
  if (trackingEmployeeDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(trackingEmployeeDataModel.toMap());

  // Add any Firestore field values
  trackingEmployeeDataModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTrackingEmployeeDataModelListFirestoreData(
  List<TrackingEmployeeDataModelStruct>? trackingEmployeeDataModels,
) =>
    trackingEmployeeDataModels
        ?.map((e) => getTrackingEmployeeDataModelFirestoreData(e, true))
        .toList() ??
    [];
