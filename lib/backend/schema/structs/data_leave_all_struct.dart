// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataLeaveAllStruct extends FFFirebaseStruct {
  DataLeaveAllStruct({
    String? month,
    String? name,
    String? fullName,
    int? total,
    ListAllLeaveStruct? listDate,
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
  ListAllLeaveStruct? _listDate;
  ListAllLeaveStruct get listDate => _listDate ?? ListAllLeaveStruct();
  set listDate(ListAllLeaveStruct? val) => _listDate = val;

  void updateListDate(Function(ListAllLeaveStruct) updateFn) {
    updateFn(_listDate ??= ListAllLeaveStruct());
  }

  bool hasListDate() => _listDate != null;

  static DataLeaveAllStruct fromMap(Map<String, dynamic> data) =>
      DataLeaveAllStruct(
        month: data['month'] as String?,
        name: data['name'] as String?,
        fullName: data['full_name'] as String?,
        total: castToType<int>(data['total']),
        listDate: data['list_date'] is ListAllLeaveStruct
            ? data['list_date']
            : ListAllLeaveStruct.maybeFromMap(data['list_date']),
      );

  static DataLeaveAllStruct? maybeFromMap(dynamic data) => data is Map
      ? DataLeaveAllStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'name': _name,
        'full_name': _fullName,
        'total': _total,
        'list_date': _listDate?.toMap(),
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
        ),
      }.withoutNulls;

  static DataLeaveAllStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataLeaveAllStruct(
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
        listDate: deserializeStructParam(
          data['list_date'],
          ParamType.DataStruct,
          false,
          structBuilder: ListAllLeaveStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DataLeaveAllStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataLeaveAllStruct &&
        month == other.month &&
        name == other.name &&
        fullName == other.fullName &&
        total == other.total &&
        listDate == other.listDate;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([month, name, fullName, total, listDate]);
}

DataLeaveAllStruct createDataLeaveAllStruct({
  String? month,
  String? name,
  String? fullName,
  int? total,
  ListAllLeaveStruct? listDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataLeaveAllStruct(
      month: month,
      name: name,
      fullName: fullName,
      total: total,
      listDate: listDate ?? (clearUnsetFields ? ListAllLeaveStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataLeaveAllStruct? updateDataLeaveAllStruct(
  DataLeaveAllStruct? dataLeaveAll, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dataLeaveAll
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataLeaveAllStructData(
  Map<String, dynamic> firestoreData,
  DataLeaveAllStruct? dataLeaveAll,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dataLeaveAll == null) {
    return;
  }
  if (dataLeaveAll.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dataLeaveAll.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dataLeaveAllData =
      getDataLeaveAllFirestoreData(dataLeaveAll, forFieldValue);
  final nestedData =
      dataLeaveAllData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dataLeaveAll.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataLeaveAllFirestoreData(
  DataLeaveAllStruct? dataLeaveAll, [
  bool forFieldValue = false,
]) {
  if (dataLeaveAll == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dataLeaveAll.toMap());

  // Handle nested data for "list_date" field.
  addListAllLeaveStructData(
    firestoreData,
    dataLeaveAll.hasListDate() ? dataLeaveAll.listDate : null,
    'list_date',
    forFieldValue,
  );

  // Add any Firestore field values
  dataLeaveAll.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDataLeaveAllListFirestoreData(
  List<DataLeaveAllStruct>? dataLeaveAlls,
) =>
    dataLeaveAlls?.map((e) => getDataLeaveAllFirestoreData(e, true)).toList() ??
    [];
