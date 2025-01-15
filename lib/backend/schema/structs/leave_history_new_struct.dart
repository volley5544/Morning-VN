// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LeaveHistoryNewStruct extends FFFirebaseStruct {
  LeaveHistoryNewStruct({
    String? month,
    String? name,
    String? fullName,
    int? total,
    List<ListDateStruct>? listDate,
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
  List<ListDateStruct>? _listDate;
  List<ListDateStruct> get listDate => _listDate ?? const [];
  set listDate(List<ListDateStruct>? val) => _listDate = val;

  void updateListDate(Function(List<ListDateStruct>) updateFn) {
    updateFn(_listDate ??= []);
  }

  bool hasListDate() => _listDate != null;

  static LeaveHistoryNewStruct fromMap(Map<String, dynamic> data) =>
      LeaveHistoryNewStruct(
        month: data['month'] as String?,
        name: data['name'] as String?,
        fullName: data['full_name'] as String?,
        total: castToType<int>(data['total']),
        listDate: getStructList(
          data['list_date'],
          ListDateStruct.fromMap,
        ),
      );

  static LeaveHistoryNewStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveHistoryNewStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'name': _name,
        'full_name': _fullName,
        'total': _total,
        'list_date': _listDate?.map((e) => e.toMap()).toList(),
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
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static LeaveHistoryNewStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveHistoryNewStruct(
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
        listDate: deserializeStructParam<ListDateStruct>(
          data['list_date'],
          ParamType.DataStruct,
          true,
          structBuilder: ListDateStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'LeaveHistoryNewStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LeaveHistoryNewStruct &&
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

LeaveHistoryNewStruct createLeaveHistoryNewStruct({
  String? month,
  String? name,
  String? fullName,
  int? total,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveHistoryNewStruct(
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

LeaveHistoryNewStruct? updateLeaveHistoryNewStruct(
  LeaveHistoryNewStruct? leaveHistoryNew, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveHistoryNew
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveHistoryNewStructData(
  Map<String, dynamic> firestoreData,
  LeaveHistoryNewStruct? leaveHistoryNew,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveHistoryNew == null) {
    return;
  }
  if (leaveHistoryNew.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveHistoryNew.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveHistoryNewData =
      getLeaveHistoryNewFirestoreData(leaveHistoryNew, forFieldValue);
  final nestedData =
      leaveHistoryNewData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveHistoryNew.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveHistoryNewFirestoreData(
  LeaveHistoryNewStruct? leaveHistoryNew, [
  bool forFieldValue = false,
]) {
  if (leaveHistoryNew == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveHistoryNew.toMap());

  // Add any Firestore field values
  leaveHistoryNew.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveHistoryNewListFirestoreData(
  List<LeaveHistoryNewStruct>? leaveHistoryNews,
) =>
    leaveHistoryNews
        ?.map((e) => getLeaveHistoryNewFirestoreData(e, true))
        .toList() ??
    [];
