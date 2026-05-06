// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ListAllLeaveStruct extends FFFirebaseStruct {
  ListAllLeaveStruct({
    String? empCode,
    String? fullName,
    String? leaveId,
    String? leaveName,
    String? leaveStatusApprove,
    String? leaveStatusName,
    String? leaveCountDay,
    String? leaveStartDate,
    String? leaveEndDate,
    String? leaveStartEndDate,
    String? leavePeriod,
    String? leavePeriodName,
    String? empTel,
    String? leaveReason,
    List<String>? leaveDocument,
    String? id,
    String? createDate,
    String? updateDate,
    String? updateBy,
    String? color,
    List<LeaveDetailStruct>? leaveDetail,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _empCode = empCode,
        _fullName = fullName,
        _leaveId = leaveId,
        _leaveName = leaveName,
        _leaveStatusApprove = leaveStatusApprove,
        _leaveStatusName = leaveStatusName,
        _leaveCountDay = leaveCountDay,
        _leaveStartDate = leaveStartDate,
        _leaveEndDate = leaveEndDate,
        _leaveStartEndDate = leaveStartEndDate,
        _leavePeriod = leavePeriod,
        _leavePeriodName = leavePeriodName,
        _empTel = empTel,
        _leaveReason = leaveReason,
        _leaveDocument = leaveDocument,
        _id = id,
        _createDate = createDate,
        _updateDate = updateDate,
        _updateBy = updateBy,
        _color = color,
        _leaveDetail = leaveDetail,
        super(firestoreUtilData);

  // "emp_code" field.
  String? _empCode;
  String get empCode => _empCode ?? '';
  set empCode(String? val) => _empCode = val;

  bool hasEmpCode() => _empCode != null;

  // "full_name" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  set fullName(String? val) => _fullName = val;

  bool hasFullName() => _fullName != null;

  // "leave_id" field.
  String? _leaveId;
  String get leaveId => _leaveId ?? '';
  set leaveId(String? val) => _leaveId = val;

  bool hasLeaveId() => _leaveId != null;

  // "leave_name" field.
  String? _leaveName;
  String get leaveName => _leaveName ?? '';
  set leaveName(String? val) => _leaveName = val;

  bool hasLeaveName() => _leaveName != null;

  // "leave_status_approve" field.
  String? _leaveStatusApprove;
  String get leaveStatusApprove => _leaveStatusApprove ?? '';
  set leaveStatusApprove(String? val) => _leaveStatusApprove = val;

  bool hasLeaveStatusApprove() => _leaveStatusApprove != null;

  // "leave_status_name" field.
  String? _leaveStatusName;
  String get leaveStatusName => _leaveStatusName ?? '';
  set leaveStatusName(String? val) => _leaveStatusName = val;

  bool hasLeaveStatusName() => _leaveStatusName != null;

  // "leave_count_day" field.
  String? _leaveCountDay;
  String get leaveCountDay => _leaveCountDay ?? '';
  set leaveCountDay(String? val) => _leaveCountDay = val;

  bool hasLeaveCountDay() => _leaveCountDay != null;

  // "leave_start_date" field.
  String? _leaveStartDate;
  String get leaveStartDate => _leaveStartDate ?? '';
  set leaveStartDate(String? val) => _leaveStartDate = val;

  bool hasLeaveStartDate() => _leaveStartDate != null;

  // "leave_end_date" field.
  String? _leaveEndDate;
  String get leaveEndDate => _leaveEndDate ?? '';
  set leaveEndDate(String? val) => _leaveEndDate = val;

  bool hasLeaveEndDate() => _leaveEndDate != null;

  // "leave_start_end_date" field.
  String? _leaveStartEndDate;
  String get leaveStartEndDate => _leaveStartEndDate ?? '';
  set leaveStartEndDate(String? val) => _leaveStartEndDate = val;

  bool hasLeaveStartEndDate() => _leaveStartEndDate != null;

  // "leave_period" field.
  String? _leavePeriod;
  String get leavePeriod => _leavePeriod ?? '';
  set leavePeriod(String? val) => _leavePeriod = val;

  bool hasLeavePeriod() => _leavePeriod != null;

  // "leave_period_name" field.
  String? _leavePeriodName;
  String get leavePeriodName => _leavePeriodName ?? '';
  set leavePeriodName(String? val) => _leavePeriodName = val;

  bool hasLeavePeriodName() => _leavePeriodName != null;

  // "emp_tel" field.
  String? _empTel;
  String get empTel => _empTel ?? '';
  set empTel(String? val) => _empTel = val;

  bool hasEmpTel() => _empTel != null;

  // "leave_reason" field.
  String? _leaveReason;
  String get leaveReason => _leaveReason ?? '';
  set leaveReason(String? val) => _leaveReason = val;

  bool hasLeaveReason() => _leaveReason != null;

  // "leave_document" field.
  List<String>? _leaveDocument;
  List<String> get leaveDocument => _leaveDocument ?? const [];
  set leaveDocument(List<String>? val) => _leaveDocument = val;

  void updateLeaveDocument(Function(List<String>) updateFn) {
    updateFn(_leaveDocument ??= []);
  }

  bool hasLeaveDocument() => _leaveDocument != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "create_date" field.
  String? _createDate;
  String get createDate => _createDate ?? '';
  set createDate(String? val) => _createDate = val;

  bool hasCreateDate() => _createDate != null;

  // "update_date" field.
  String? _updateDate;
  String get updateDate => _updateDate ?? '';
  set updateDate(String? val) => _updateDate = val;

  bool hasUpdateDate() => _updateDate != null;

  // "update_by" field.
  String? _updateBy;
  String get updateBy => _updateBy ?? '';
  set updateBy(String? val) => _updateBy = val;

  bool hasUpdateBy() => _updateBy != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "leave_detail" field.
  List<LeaveDetailStruct>? _leaveDetail;
  List<LeaveDetailStruct> get leaveDetail => _leaveDetail ?? const [];
  set leaveDetail(List<LeaveDetailStruct>? val) => _leaveDetail = val;

  void updateLeaveDetail(Function(List<LeaveDetailStruct>) updateFn) {
    updateFn(_leaveDetail ??= []);
  }

  bool hasLeaveDetail() => _leaveDetail != null;

  static ListAllLeaveStruct fromMap(Map<String, dynamic> data) =>
      ListAllLeaveStruct(
        empCode: data['emp_code'] as String?,
        fullName: data['full_name'] as String?,
        leaveId: data['leave_id'] as String?,
        leaveName: data['leave_name'] as String?,
        leaveStatusApprove: data['leave_status_approve'] as String?,
        leaveStatusName: data['leave_status_name'] as String?,
        leaveCountDay: data['leave_count_day'] as String?,
        leaveStartDate: data['leave_start_date'] as String?,
        leaveEndDate: data['leave_end_date'] as String?,
        leaveStartEndDate: data['leave_start_end_date'] as String?,
        leavePeriod: data['leave_period'] as String?,
        leavePeriodName: data['leave_period_name'] as String?,
        empTel: data['emp_tel'] as String?,
        leaveReason: data['leave_reason'] as String?,
        leaveDocument: getDataList(data['leave_document']),
        id: data['id'] as String?,
        createDate: data['create_date'] as String?,
        updateDate: data['update_date'] as String?,
        updateBy: data['update_by'] as String?,
        color: data['color'] as String?,
        leaveDetail: getStructList(
          data['leave_detail'],
          LeaveDetailStruct.fromMap,
        ),
      );

  static ListAllLeaveStruct? maybeFromMap(dynamic data) => data is Map
      ? ListAllLeaveStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'emp_code': _empCode,
        'full_name': _fullName,
        'leave_id': _leaveId,
        'leave_name': _leaveName,
        'leave_status_approve': _leaveStatusApprove,
        'leave_status_name': _leaveStatusName,
        'leave_count_day': _leaveCountDay,
        'leave_start_date': _leaveStartDate,
        'leave_end_date': _leaveEndDate,
        'leave_start_end_date': _leaveStartEndDate,
        'leave_period': _leavePeriod,
        'leave_period_name': _leavePeriodName,
        'emp_tel': _empTel,
        'leave_reason': _leaveReason,
        'leave_document': _leaveDocument,
        'id': _id,
        'create_date': _createDate,
        'update_date': _updateDate,
        'update_by': _updateBy,
        'color': _color,
        'leave_detail': _leaveDetail?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'emp_code': serializeParam(
          _empCode,
          ParamType.String,
        ),
        'full_name': serializeParam(
          _fullName,
          ParamType.String,
        ),
        'leave_id': serializeParam(
          _leaveId,
          ParamType.String,
        ),
        'leave_name': serializeParam(
          _leaveName,
          ParamType.String,
        ),
        'leave_status_approve': serializeParam(
          _leaveStatusApprove,
          ParamType.String,
        ),
        'leave_status_name': serializeParam(
          _leaveStatusName,
          ParamType.String,
        ),
        'leave_count_day': serializeParam(
          _leaveCountDay,
          ParamType.String,
        ),
        'leave_start_date': serializeParam(
          _leaveStartDate,
          ParamType.String,
        ),
        'leave_end_date': serializeParam(
          _leaveEndDate,
          ParamType.String,
        ),
        'leave_start_end_date': serializeParam(
          _leaveStartEndDate,
          ParamType.String,
        ),
        'leave_period': serializeParam(
          _leavePeriod,
          ParamType.String,
        ),
        'leave_period_name': serializeParam(
          _leavePeriodName,
          ParamType.String,
        ),
        'emp_tel': serializeParam(
          _empTel,
          ParamType.String,
        ),
        'leave_reason': serializeParam(
          _leaveReason,
          ParamType.String,
        ),
        'leave_document': serializeParam(
          _leaveDocument,
          ParamType.String,
          isList: true,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'create_date': serializeParam(
          _createDate,
          ParamType.String,
        ),
        'update_date': serializeParam(
          _updateDate,
          ParamType.String,
        ),
        'update_by': serializeParam(
          _updateBy,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'leave_detail': serializeParam(
          _leaveDetail,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ListAllLeaveStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListAllLeaveStruct(
        empCode: deserializeParam(
          data['emp_code'],
          ParamType.String,
          false,
        ),
        fullName: deserializeParam(
          data['full_name'],
          ParamType.String,
          false,
        ),
        leaveId: deserializeParam(
          data['leave_id'],
          ParamType.String,
          false,
        ),
        leaveName: deserializeParam(
          data['leave_name'],
          ParamType.String,
          false,
        ),
        leaveStatusApprove: deserializeParam(
          data['leave_status_approve'],
          ParamType.String,
          false,
        ),
        leaveStatusName: deserializeParam(
          data['leave_status_name'],
          ParamType.String,
          false,
        ),
        leaveCountDay: deserializeParam(
          data['leave_count_day'],
          ParamType.String,
          false,
        ),
        leaveStartDate: deserializeParam(
          data['leave_start_date'],
          ParamType.String,
          false,
        ),
        leaveEndDate: deserializeParam(
          data['leave_end_date'],
          ParamType.String,
          false,
        ),
        leaveStartEndDate: deserializeParam(
          data['leave_start_end_date'],
          ParamType.String,
          false,
        ),
        leavePeriod: deserializeParam(
          data['leave_period'],
          ParamType.String,
          false,
        ),
        leavePeriodName: deserializeParam(
          data['leave_period_name'],
          ParamType.String,
          false,
        ),
        empTel: deserializeParam(
          data['emp_tel'],
          ParamType.String,
          false,
        ),
        leaveReason: deserializeParam(
          data['leave_reason'],
          ParamType.String,
          false,
        ),
        leaveDocument: deserializeParam<String>(
          data['leave_document'],
          ParamType.String,
          true,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        createDate: deserializeParam(
          data['create_date'],
          ParamType.String,
          false,
        ),
        updateDate: deserializeParam(
          data['update_date'],
          ParamType.String,
          false,
        ),
        updateBy: deserializeParam(
          data['update_by'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        leaveDetail: deserializeStructParam<LeaveDetailStruct>(
          data['leave_detail'],
          ParamType.DataStruct,
          true,
          structBuilder: LeaveDetailStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ListAllLeaveStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ListAllLeaveStruct &&
        empCode == other.empCode &&
        fullName == other.fullName &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveStatusApprove == other.leaveStatusApprove &&
        leaveStatusName == other.leaveStatusName &&
        leaveCountDay == other.leaveCountDay &&
        leaveStartDate == other.leaveStartDate &&
        leaveEndDate == other.leaveEndDate &&
        leaveStartEndDate == other.leaveStartEndDate &&
        leavePeriod == other.leavePeriod &&
        leavePeriodName == other.leavePeriodName &&
        empTel == other.empTel &&
        leaveReason == other.leaveReason &&
        listEquality.equals(leaveDocument, other.leaveDocument) &&
        id == other.id &&
        createDate == other.createDate &&
        updateDate == other.updateDate &&
        updateBy == other.updateBy &&
        color == other.color &&
        listEquality.equals(leaveDetail, other.leaveDetail);
  }

  @override
  int get hashCode => const ListEquality().hash([
        empCode,
        fullName,
        leaveId,
        leaveName,
        leaveStatusApprove,
        leaveStatusName,
        leaveCountDay,
        leaveStartDate,
        leaveEndDate,
        leaveStartEndDate,
        leavePeriod,
        leavePeriodName,
        empTel,
        leaveReason,
        leaveDocument,
        id,
        createDate,
        updateDate,
        updateBy,
        color,
        leaveDetail
      ]);
}

ListAllLeaveStruct createListAllLeaveStruct({
  String? empCode,
  String? fullName,
  String? leaveId,
  String? leaveName,
  String? leaveStatusApprove,
  String? leaveStatusName,
  String? leaveCountDay,
  String? leaveStartDate,
  String? leaveEndDate,
  String? leaveStartEndDate,
  String? leavePeriod,
  String? leavePeriodName,
  String? empTel,
  String? leaveReason,
  String? id,
  String? createDate,
  String? updateDate,
  String? updateBy,
  String? color,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListAllLeaveStruct(
      empCode: empCode,
      fullName: fullName,
      leaveId: leaveId,
      leaveName: leaveName,
      leaveStatusApprove: leaveStatusApprove,
      leaveStatusName: leaveStatusName,
      leaveCountDay: leaveCountDay,
      leaveStartDate: leaveStartDate,
      leaveEndDate: leaveEndDate,
      leaveStartEndDate: leaveStartEndDate,
      leavePeriod: leavePeriod,
      leavePeriodName: leavePeriodName,
      empTel: empTel,
      leaveReason: leaveReason,
      id: id,
      createDate: createDate,
      updateDate: updateDate,
      updateBy: updateBy,
      color: color,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListAllLeaveStruct? updateListAllLeaveStruct(
  ListAllLeaveStruct? listAllLeave, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listAllLeave
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListAllLeaveStructData(
  Map<String, dynamic> firestoreData,
  ListAllLeaveStruct? listAllLeave,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listAllLeave == null) {
    return;
  }
  if (listAllLeave.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listAllLeave.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listAllLeaveData =
      getListAllLeaveFirestoreData(listAllLeave, forFieldValue);
  final nestedData =
      listAllLeaveData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listAllLeave.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListAllLeaveFirestoreData(
  ListAllLeaveStruct? listAllLeave, [
  bool forFieldValue = false,
]) {
  if (listAllLeave == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listAllLeave.toMap());

  // Add any Firestore field values
  mapToFirestore(listAllLeave.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListAllLeaveListFirestoreData(
  List<ListAllLeaveStruct>? listAllLeaves,
) =>
    listAllLeaves?.map((e) => getListAllLeaveFirestoreData(e, true)).toList() ??
    [];
