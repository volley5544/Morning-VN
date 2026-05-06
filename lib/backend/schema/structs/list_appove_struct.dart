// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ListAppoveStruct extends FFFirebaseStruct {
  ListAppoveStruct({
    String? empCode,
    String? fullName,
    String? leaveId,
    String? leaveName,
    String? leaveCountDay,
    String? leaveStartDate,
    String? leaveEndDate,
    String? leavePeriod,
    String? empTel,
    String? leaveReason,
    String? id,
    String? nickName,
    String? leaveStatusName,
    String? leavePeriodName,
    String? createDate,
    List<LeaveDetailStruct>? leaveDetail,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _empCode = empCode,
        _fullName = fullName,
        _leaveId = leaveId,
        _leaveName = leaveName,
        _leaveCountDay = leaveCountDay,
        _leaveStartDate = leaveStartDate,
        _leaveEndDate = leaveEndDate,
        _leavePeriod = leavePeriod,
        _empTel = empTel,
        _leaveReason = leaveReason,
        _id = id,
        _nickName = nickName,
        _leaveStatusName = leaveStatusName,
        _leavePeriodName = leavePeriodName,
        _createDate = createDate,
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

  // "leave_period" field.
  String? _leavePeriod;
  String get leavePeriod => _leavePeriod ?? '';
  set leavePeriod(String? val) => _leavePeriod = val;

  bool hasLeavePeriod() => _leavePeriod != null;

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

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "nick_name" field.
  String? _nickName;
  String get nickName => _nickName ?? '';
  set nickName(String? val) => _nickName = val;

  bool hasNickName() => _nickName != null;

  // "leave_status_name" field.
  String? _leaveStatusName;
  String get leaveStatusName => _leaveStatusName ?? '';
  set leaveStatusName(String? val) => _leaveStatusName = val;

  bool hasLeaveStatusName() => _leaveStatusName != null;

  // "leave_period_name" field.
  String? _leavePeriodName;
  String get leavePeriodName => _leavePeriodName ?? '';
  set leavePeriodName(String? val) => _leavePeriodName = val;

  bool hasLeavePeriodName() => _leavePeriodName != null;

  // "create_date" field.
  String? _createDate;
  String get createDate => _createDate ?? '';
  set createDate(String? val) => _createDate = val;

  bool hasCreateDate() => _createDate != null;

  // "leave_detail" field.
  List<LeaveDetailStruct>? _leaveDetail;
  List<LeaveDetailStruct> get leaveDetail => _leaveDetail ?? const [];
  set leaveDetail(List<LeaveDetailStruct>? val) => _leaveDetail = val;

  void updateLeaveDetail(Function(List<LeaveDetailStruct>) updateFn) {
    updateFn(_leaveDetail ??= []);
  }

  bool hasLeaveDetail() => _leaveDetail != null;

  static ListAppoveStruct fromMap(Map<String, dynamic> data) =>
      ListAppoveStruct(
        empCode: data['emp_code'] as String?,
        fullName: data['full_name'] as String?,
        leaveId: data['leave_id'] as String?,
        leaveName: data['leave_name'] as String?,
        leaveCountDay: data['leave_count_day'] as String?,
        leaveStartDate: data['leave_start_date'] as String?,
        leaveEndDate: data['leave_end_date'] as String?,
        leavePeriod: data['leave_period'] as String?,
        empTel: data['emp_tel'] as String?,
        leaveReason: data['leave_reason'] as String?,
        id: data['id'] as String?,
        nickName: data['nick_name'] as String?,
        leaveStatusName: data['leave_status_name'] as String?,
        leavePeriodName: data['leave_period_name'] as String?,
        createDate: data['create_date'] as String?,
        leaveDetail: getStructList(
          data['leave_detail'],
          LeaveDetailStruct.fromMap,
        ),
      );

  static ListAppoveStruct? maybeFromMap(dynamic data) => data is Map
      ? ListAppoveStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'emp_code': _empCode,
        'full_name': _fullName,
        'leave_id': _leaveId,
        'leave_name': _leaveName,
        'leave_count_day': _leaveCountDay,
        'leave_start_date': _leaveStartDate,
        'leave_end_date': _leaveEndDate,
        'leave_period': _leavePeriod,
        'emp_tel': _empTel,
        'leave_reason': _leaveReason,
        'id': _id,
        'nick_name': _nickName,
        'leave_status_name': _leaveStatusName,
        'leave_period_name': _leavePeriodName,
        'create_date': _createDate,
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
        'leave_period': serializeParam(
          _leavePeriod,
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
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'nick_name': serializeParam(
          _nickName,
          ParamType.String,
        ),
        'leave_status_name': serializeParam(
          _leaveStatusName,
          ParamType.String,
        ),
        'leave_period_name': serializeParam(
          _leavePeriodName,
          ParamType.String,
        ),
        'create_date': serializeParam(
          _createDate,
          ParamType.String,
        ),
        'leave_detail': serializeParam(
          _leaveDetail,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ListAppoveStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListAppoveStruct(
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
        leavePeriod: deserializeParam(
          data['leave_period'],
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
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        nickName: deserializeParam(
          data['nick_name'],
          ParamType.String,
          false,
        ),
        leaveStatusName: deserializeParam(
          data['leave_status_name'],
          ParamType.String,
          false,
        ),
        leavePeriodName: deserializeParam(
          data['leave_period_name'],
          ParamType.String,
          false,
        ),
        createDate: deserializeParam(
          data['create_date'],
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
  String toString() => 'ListAppoveStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ListAppoveStruct &&
        empCode == other.empCode &&
        fullName == other.fullName &&
        leaveId == other.leaveId &&
        leaveName == other.leaveName &&
        leaveCountDay == other.leaveCountDay &&
        leaveStartDate == other.leaveStartDate &&
        leaveEndDate == other.leaveEndDate &&
        leavePeriod == other.leavePeriod &&
        empTel == other.empTel &&
        leaveReason == other.leaveReason &&
        id == other.id &&
        nickName == other.nickName &&
        leaveStatusName == other.leaveStatusName &&
        leavePeriodName == other.leavePeriodName &&
        createDate == other.createDate &&
        listEquality.equals(leaveDetail, other.leaveDetail);
  }

  @override
  int get hashCode => const ListEquality().hash([
        empCode,
        fullName,
        leaveId,
        leaveName,
        leaveCountDay,
        leaveStartDate,
        leaveEndDate,
        leavePeriod,
        empTel,
        leaveReason,
        id,
        nickName,
        leaveStatusName,
        leavePeriodName,
        createDate,
        leaveDetail
      ]);
}

ListAppoveStruct createListAppoveStruct({
  String? empCode,
  String? fullName,
  String? leaveId,
  String? leaveName,
  String? leaveCountDay,
  String? leaveStartDate,
  String? leaveEndDate,
  String? leavePeriod,
  String? empTel,
  String? leaveReason,
  String? id,
  String? nickName,
  String? leaveStatusName,
  String? leavePeriodName,
  String? createDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListAppoveStruct(
      empCode: empCode,
      fullName: fullName,
      leaveId: leaveId,
      leaveName: leaveName,
      leaveCountDay: leaveCountDay,
      leaveStartDate: leaveStartDate,
      leaveEndDate: leaveEndDate,
      leavePeriod: leavePeriod,
      empTel: empTel,
      leaveReason: leaveReason,
      id: id,
      nickName: nickName,
      leaveStatusName: leaveStatusName,
      leavePeriodName: leavePeriodName,
      createDate: createDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListAppoveStruct? updateListAppoveStruct(
  ListAppoveStruct? listAppove, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listAppove
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListAppoveStructData(
  Map<String, dynamic> firestoreData,
  ListAppoveStruct? listAppove,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (listAppove == null) {
    return;
  }
  if (listAppove.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listAppove.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final listAppoveData = getListAppoveFirestoreData(listAppove, forFieldValue);
  final nestedData = listAppoveData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listAppove.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListAppoveFirestoreData(
  ListAppoveStruct? listAppove, [
  bool forFieldValue = false,
]) {
  if (listAppove == null) {
    return {};
  }
  final firestoreData = mapToFirestore(listAppove.toMap());

  // Add any Firestore field values
  mapToFirestore(listAppove.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getListAppoveListFirestoreData(
  List<ListAppoveStruct>? listAppoves,
) =>
    listAppoves?.map((e) => getListAppoveFirestoreData(e, true)).toList() ?? [];
