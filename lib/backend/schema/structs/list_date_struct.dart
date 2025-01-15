// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ListDateStruct extends FFFirebaseStruct {
  ListDateStruct({
    String? leaveId,
    String? leaveName,
    String? leaveCountDay,
    String? leaveStartDate,
    String? leaveStartDateFormat,
    String? leaveEndDate,
    String? leaveEndDateFormat,
    String? leavePeriod,
    String? leaveReason,
    String? combineDate,
    List<LeaveDetailsStruct>? leaveDetails,
    String? leaveStatusApprove,
    String? leaveStatus,
    String? color,
    String? createDatetime,
    List<String>? headApprove,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveId = leaveId,
        _leaveName = leaveName,
        _leaveCountDay = leaveCountDay,
        _leaveStartDate = leaveStartDate,
        _leaveStartDateFormat = leaveStartDateFormat,
        _leaveEndDate = leaveEndDate,
        _leaveEndDateFormat = leaveEndDateFormat,
        _leavePeriod = leavePeriod,
        _leaveReason = leaveReason,
        _combineDate = combineDate,
        _leaveDetails = leaveDetails,
        _leaveStatusApprove = leaveStatusApprove,
        _leaveStatus = leaveStatus,
        _color = color,
        _createDatetime = createDatetime,
        _headApprove = headApprove,
        super(firestoreUtilData);

  // "LEAVE_ID" field.
  String? _leaveId;
  String get leaveId => _leaveId ?? '';
  set leaveId(String? val) => _leaveId = val;

  bool hasLeaveId() => _leaveId != null;

  // "LEAVE_NAME" field.
  String? _leaveName;
  String get leaveName => _leaveName ?? '';
  set leaveName(String? val) => _leaveName = val;

  bool hasLeaveName() => _leaveName != null;

  // "LEAVE_COUNT_DAY" field.
  String? _leaveCountDay;
  String get leaveCountDay => _leaveCountDay ?? '';
  set leaveCountDay(String? val) => _leaveCountDay = val;

  bool hasLeaveCountDay() => _leaveCountDay != null;

  // "LEAVE_START_DATE" field.
  String? _leaveStartDate;
  String get leaveStartDate => _leaveStartDate ?? '';
  set leaveStartDate(String? val) => _leaveStartDate = val;

  bool hasLeaveStartDate() => _leaveStartDate != null;

  // "LEAVE_START_DATE_FORMAT" field.
  String? _leaveStartDateFormat;
  String get leaveStartDateFormat => _leaveStartDateFormat ?? '';
  set leaveStartDateFormat(String? val) => _leaveStartDateFormat = val;

  bool hasLeaveStartDateFormat() => _leaveStartDateFormat != null;

  // "LEAVE_END_DATE" field.
  String? _leaveEndDate;
  String get leaveEndDate => _leaveEndDate ?? '';
  set leaveEndDate(String? val) => _leaveEndDate = val;

  bool hasLeaveEndDate() => _leaveEndDate != null;

  // "LEAVE_END_DATE_FORMAT" field.
  String? _leaveEndDateFormat;
  String get leaveEndDateFormat => _leaveEndDateFormat ?? '';
  set leaveEndDateFormat(String? val) => _leaveEndDateFormat = val;

  bool hasLeaveEndDateFormat() => _leaveEndDateFormat != null;

  // "LEAVE_PERIOD" field.
  String? _leavePeriod;
  String get leavePeriod => _leavePeriod ?? '';
  set leavePeriod(String? val) => _leavePeriod = val;

  bool hasLeavePeriod() => _leavePeriod != null;

  // "LEAVE_REASON" field.
  String? _leaveReason;
  String get leaveReason => _leaveReason ?? '';
  set leaveReason(String? val) => _leaveReason = val;

  bool hasLeaveReason() => _leaveReason != null;

  // "COMBINE_DATE" field.
  String? _combineDate;
  String get combineDate => _combineDate ?? '';
  set combineDate(String? val) => _combineDate = val;

  bool hasCombineDate() => _combineDate != null;

  // "LEAVE_DETAILS" field.
  List<LeaveDetailsStruct>? _leaveDetails;
  List<LeaveDetailsStruct> get leaveDetails => _leaveDetails ?? const [];
  set leaveDetails(List<LeaveDetailsStruct>? val) => _leaveDetails = val;

  void updateLeaveDetails(Function(List<LeaveDetailsStruct>) updateFn) {
    updateFn(_leaveDetails ??= []);
  }

  bool hasLeaveDetails() => _leaveDetails != null;

  // "LEAVE_STATUS_APPROVE" field.
  String? _leaveStatusApprove;
  String get leaveStatusApprove => _leaveStatusApprove ?? '';
  set leaveStatusApprove(String? val) => _leaveStatusApprove = val;

  bool hasLeaveStatusApprove() => _leaveStatusApprove != null;

  // "LEAVE_STATUS" field.
  String? _leaveStatus;
  String get leaveStatus => _leaveStatus ?? '';
  set leaveStatus(String? val) => _leaveStatus = val;

  bool hasLeaveStatus() => _leaveStatus != null;

  // "COLOR" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "CREATE_DATETIME" field.
  String? _createDatetime;
  String get createDatetime => _createDatetime ?? '';
  set createDatetime(String? val) => _createDatetime = val;

  bool hasCreateDatetime() => _createDatetime != null;

  // "HEAD_APPROVE" field.
  List<String>? _headApprove;
  List<String> get headApprove => _headApprove ?? const [];
  set headApprove(List<String>? val) => _headApprove = val;

  void updateHeadApprove(Function(List<String>) updateFn) {
    updateFn(_headApprove ??= []);
  }

  bool hasHeadApprove() => _headApprove != null;

  static ListDateStruct fromMap(Map<String, dynamic> data) => ListDateStruct(
        leaveId: data['LEAVE_ID'] as String?,
        leaveName: data['LEAVE_NAME'] as String?,
        leaveCountDay: data['LEAVE_COUNT_DAY'] as String?,
        leaveStartDate: data['LEAVE_START_DATE'] as String?,
        leaveStartDateFormat: data['LEAVE_START_DATE_FORMAT'] as String?,
        leaveEndDate: data['LEAVE_END_DATE'] as String?,
        leaveEndDateFormat: data['LEAVE_END_DATE_FORMAT'] as String?,
        leavePeriod: data['LEAVE_PERIOD'] as String?,
        leaveReason: data['LEAVE_REASON'] as String?,
        combineDate: data['COMBINE_DATE'] as String?,
        leaveDetails: getStructList(
          data['LEAVE_DETAILS'],
          LeaveDetailsStruct.fromMap,
        ),
        leaveStatusApprove: data['LEAVE_STATUS_APPROVE'] as String?,
        leaveStatus: data['LEAVE_STATUS'] as String?,
        color: data['COLOR'] as String?,
        createDatetime: data['CREATE_DATETIME'] as String?,
        headApprove: getDataList(data['HEAD_APPROVE']),
      );

  static ListDateStruct? maybeFromMap(dynamic data) =>
      data is Map ? ListDateStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'LEAVE_ID': _leaveId,
        'LEAVE_NAME': _leaveName,
        'LEAVE_COUNT_DAY': _leaveCountDay,
        'LEAVE_START_DATE': _leaveStartDate,
        'LEAVE_START_DATE_FORMAT': _leaveStartDateFormat,
        'LEAVE_END_DATE': _leaveEndDate,
        'LEAVE_END_DATE_FORMAT': _leaveEndDateFormat,
        'LEAVE_PERIOD': _leavePeriod,
        'LEAVE_REASON': _leaveReason,
        'COMBINE_DATE': _combineDate,
        'LEAVE_DETAILS': _leaveDetails?.map((e) => e.toMap()).toList(),
        'LEAVE_STATUS_APPROVE': _leaveStatusApprove,
        'LEAVE_STATUS': _leaveStatus,
        'COLOR': _color,
        'CREATE_DATETIME': _createDatetime,
        'HEAD_APPROVE': _headApprove,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'LEAVE_ID': serializeParam(
          _leaveId,
          ParamType.String,
        ),
        'LEAVE_NAME': serializeParam(
          _leaveName,
          ParamType.String,
        ),
        'LEAVE_COUNT_DAY': serializeParam(
          _leaveCountDay,
          ParamType.String,
        ),
        'LEAVE_START_DATE': serializeParam(
          _leaveStartDate,
          ParamType.String,
        ),
        'LEAVE_START_DATE_FORMAT': serializeParam(
          _leaveStartDateFormat,
          ParamType.String,
        ),
        'LEAVE_END_DATE': serializeParam(
          _leaveEndDate,
          ParamType.String,
        ),
        'LEAVE_END_DATE_FORMAT': serializeParam(
          _leaveEndDateFormat,
          ParamType.String,
        ),
        'LEAVE_PERIOD': serializeParam(
          _leavePeriod,
          ParamType.String,
        ),
        'LEAVE_REASON': serializeParam(
          _leaveReason,
          ParamType.String,
        ),
        'COMBINE_DATE': serializeParam(
          _combineDate,
          ParamType.String,
        ),
        'LEAVE_DETAILS': serializeParam(
          _leaveDetails,
          ParamType.DataStruct,
          isList: true,
        ),
        'LEAVE_STATUS_APPROVE': serializeParam(
          _leaveStatusApprove,
          ParamType.String,
        ),
        'LEAVE_STATUS': serializeParam(
          _leaveStatus,
          ParamType.String,
        ),
        'COLOR': serializeParam(
          _color,
          ParamType.String,
        ),
        'CREATE_DATETIME': serializeParam(
          _createDatetime,
          ParamType.String,
        ),
        'HEAD_APPROVE': serializeParam(
          _headApprove,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ListDateStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListDateStruct(
        leaveId: deserializeParam(
          data['LEAVE_ID'],
          ParamType.String,
          false,
        ),
        leaveName: deserializeParam(
          data['LEAVE_NAME'],
          ParamType.String,
          false,
        ),
        leaveCountDay: deserializeParam(
          data['LEAVE_COUNT_DAY'],
          ParamType.String,
          false,
        ),
        leaveStartDate: deserializeParam(
          data['LEAVE_START_DATE'],
          ParamType.String,
          false,
        ),
        leaveStartDateFormat: deserializeParam(
          data['LEAVE_START_DATE_FORMAT'],
          ParamType.String,
          false,
        ),
        leaveEndDate: deserializeParam(
          data['LEAVE_END_DATE'],
          ParamType.String,
          false,
        ),
        leaveEndDateFormat: deserializeParam(
          data['LEAVE_END_DATE_FORMAT'],
          ParamType.String,
          false,
        ),
        leavePeriod: deserializeParam(
          data['LEAVE_PERIOD'],
          ParamType.String,
          false,
        ),
        leaveReason: deserializeParam(
          data['LEAVE_REASON'],
          ParamType.String,
          false,
        ),
        combineDate: deserializeParam(
          data['COMBINE_DATE'],
          ParamType.String,
          false,
        ),
        leaveDetails: deserializeStructParam<LeaveDetailsStruct>(
          data['LEAVE_DETAILS'],
          ParamType.DataStruct,
          true,
          structBuilder: LeaveDetailsStruct.fromSerializableMap,
        ),
        leaveStatusApprove: deserializeParam(
          data['LEAVE_STATUS_APPROVE'],
          ParamType.String,
          false,
        ),
        leaveStatus: deserializeParam(
          data['LEAVE_STATUS'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['COLOR'],
          ParamType.String,
          false,
        ),
        createDatetime: deserializeParam(
          data['CREATE_DATETIME'],
          ParamType.String,
          false,
        ),
        headApprove: deserializeParam<String>(
          data['HEAD_APPROVE'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'ListDateStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ListDateStruct &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveCountDay == other.leaveCountDay &&
        leaveStartDate == other.leaveStartDate &&
        leaveStartDateFormat == other.leaveStartDateFormat &&
        leaveEndDate == other.leaveEndDate &&
        leaveEndDateFormat == other.leaveEndDateFormat &&
        leavePeriod == other.leavePeriod &&
        leaveReason == other.leaveReason &&
        combineDate == other.combineDate &&
        listEquality.equals(leaveDetails, other.leaveDetails) &&
        leaveStatusApprove == other.leaveStatusApprove &&
        leaveStatus == other.leaveStatus &&
        color == other.color &&
        createDatetime == other.createDatetime &&
        listEquality.equals(headApprove, other.headApprove);
  }

  @override
  int get hashCode => const ListEquality().hash([
        leaveId,
        leaveName,
        leaveCountDay,
        leaveStartDate,
        leaveStartDateFormat,
        leaveEndDate,
        leaveEndDateFormat,
        leavePeriod,
        leaveReason,
        combineDate,
        leaveDetails,
        leaveStatusApprove,
        leaveStatus,
        color,
        createDatetime,
        headApprove
      ]);
}

ListDateStruct createListDateStruct({
  String? leaveId,
  String? leaveName,
  String? leaveCountDay,
  String? leaveStartDate,
  String? leaveStartDateFormat,
  String? leaveEndDate,
  String? leaveEndDateFormat,
  String? leavePeriod,
  String? leaveReason,
  String? combineDate,
  String? leaveStatusApprove,
  String? leaveStatus,
  String? color,
  String? createDatetime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListDateStruct(
      leaveId: leaveId,
      leaveName: leaveName,
      leaveCountDay: leaveCountDay,
      leaveStartDate: leaveStartDate,
      leaveStartDateFormat: leaveStartDateFormat,
      leaveEndDate: leaveEndDate,
      leaveEndDateFormat: leaveEndDateFormat,
      leavePeriod: leavePeriod,
      leaveReason: leaveReason,
      combineDate: combineDate,
      leaveStatusApprove: leaveStatusApprove,
      leaveStatus: leaveStatus,
      color: color,
      createDatetime: createDatetime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListDateStruct? updateListDateStruct(
  ListDateStruct? listDate, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listDate
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListDateStructData(
  Map<String, dynamic> firestoreData,
  ListDateStruct? listDate,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listDate == null) {
    return;
  }
  if (listDate.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listDate.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listDateData = getListDateFirestoreData(listDate, forFieldValue);
  final nestedData = listDateData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listDate.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListDateFirestoreData(
  ListDateStruct? listDate, [
  bool forFieldValue = false,
]) {
  if (listDate == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listDate.toMap());

  // Add any Firestore field values
  listDate.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListDateListFirestoreData(
  List<ListDateStruct>? listDates,
) =>
    listDates?.map((e) => getListDateFirestoreData(e, true)).toList() ?? [];
