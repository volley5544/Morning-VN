// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LeaveHistoryStruct extends FFFirebaseStruct {
  LeaveHistoryStruct({
    String? month,
    String? name,
    String? fullName,
    int? total,
    List<String>? listDate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _month = month,
        _name = name,
        _fullName = fullName,
        _total = total,
        _listDate = listDate,
        super(firestoreUtilData);

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  set month(String? val) => _month = val;

  bool hasMonth() => _month != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "full_name" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  set fullName(String? val) => _fullName = val;

  bool hasFullName() => _fullName != null;

  // "total" field.
  int? _total;
  int get total => _total ?? 0;
  set total(int? val) => _total = val;

  void incrementTotal(int amount) => total = total + amount;

  bool hasTotal() => _total != null;

  // "list_date" field.
  List<String>? _listDate;
  List<String> get listDate => _listDate ?? const [];
  set listDate(List<String>? val) => _listDate = val;

  void updateListDate(Function(List<String>) updateFn) {
    updateFn(_listDate ??= []);
  }

  bool hasListDate() => _listDate != null;

  static LeaveHistoryStruct fromMap(Map<String, dynamic> data) =>
      LeaveHistoryStruct(
        month: data['month'] as String?,
        name: data['name'] as String?,
        fullName: data['full_name'] as String?,
        total: castToType<int>(data['total']),
        listDate: getDataList(data['list_date']),
      );

  static LeaveHistoryStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveHistoryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'name': _name,
        'full_name': _fullName,
        'total': _total,
        'list_date': _listDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'full_name': serializeParam(
          _fullName,
          ParamType.String,
        ),
        'total': serializeParam(
          _total,
          ParamType.int,
        ),
        'list_date': serializeParam(
          _listDate,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static LeaveHistoryStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveHistoryStruct(
        month: deserializeParam(
          data['month'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        fullName: deserializeParam(
          data['full_name'],
          ParamType.String,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.int,
          false,
        ),
        listDate: deserializeParam<String>(
          data['list_date'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'LeaveHistoryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LeaveHistoryStruct &&
        month == other.month &&
        name == other.name &&
        fullName == other.fullName &&
        total == other.total &&
        listEquality.equals(listDate, other.listDate);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([month, name, fullName, total, listDate]);
}

LeaveHistoryStruct createLeaveHistoryStruct({
  String? month,
  String? name,
  String? fullName,
  int? total,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveHistoryStruct(
      month: month,
      name: name,
      fullName: fullName,
      total: total,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeaveHistoryStruct? updateLeaveHistoryStruct(
  LeaveHistoryStruct? leaveHistory, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveHistory
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveHistoryStructData(
  Map<String, dynamic> firestoreData,
  LeaveHistoryStruct? leaveHistory,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveHistory == null) {
    return;
  }
  if (leaveHistory.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveHistory.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveHistoryData =
      getLeaveHistoryFirestoreData(leaveHistory, forFieldValue);
  final nestedData =
      leaveHistoryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveHistory.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveHistoryFirestoreData(
  LeaveHistoryStruct? leaveHistory, [
  bool forFieldValue = false,
]) {
  if (leaveHistory == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveHistory.toMap());

  // Add any Firestore field values
  leaveHistory.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveHistoryListFirestoreData(
  List<LeaveHistoryStruct>? leaveHistorys,
) =>
    leaveHistorys?.map((e) => getLeaveHistoryFirestoreData(e, true)).toList() ??
    [];
