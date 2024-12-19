// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CurrentYearStruct extends FFFirebaseStruct {
  CurrentYearStruct({
    String? leaveUse,
    List<LeaveDateStruct>? leaveDate,
    String? leaveLimit,
    String? leaveRemain,
    String? year,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveUse = leaveUse,
        _leaveDate = leaveDate,
        _leaveLimit = leaveLimit,
        _leaveRemain = leaveRemain,
        _year = year,
        super(firestoreUtilData);

  // "leave_use" field.
  String? _leaveUse;
  String get leaveUse => _leaveUse ?? '';
  set leaveUse(String? val) => _leaveUse = val;

  bool hasLeaveUse() => _leaveUse != null;

  // "leave_date" field.
  List<LeaveDateStruct>? _leaveDate;
  List<LeaveDateStruct> get leaveDate => _leaveDate ?? const [];
  set leaveDate(List<LeaveDateStruct>? val) => _leaveDate = val;

  void updateLeaveDate(Function(List<LeaveDateStruct>) updateFn) {
    updateFn(_leaveDate ??= []);
  }

  bool hasLeaveDate() => _leaveDate != null;

  // "leave_limit" field.
  String? _leaveLimit;
  String get leaveLimit => _leaveLimit ?? '';
  set leaveLimit(String? val) => _leaveLimit = val;

  bool hasLeaveLimit() => _leaveLimit != null;

  // "leave_remain" field.
  String? _leaveRemain;
  String get leaveRemain => _leaveRemain ?? '';
  set leaveRemain(String? val) => _leaveRemain = val;

  bool hasLeaveRemain() => _leaveRemain != null;

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  set year(String? val) => _year = val;

  bool hasYear() => _year != null;

  static CurrentYearStruct fromMap(Map<String, dynamic> data) =>
      CurrentYearStruct(
        leaveUse: data['leave_use'] as String?,
        leaveDate: getStructList(
          data['leave_date'],
          LeaveDateStruct.fromMap,
        ),
        leaveLimit: data['leave_limit'] as String?,
        leaveRemain: data['leave_remain'] as String?,
        year: data['year'] as String?,
      );

  static CurrentYearStruct? maybeFromMap(dynamic data) => data is Map
      ? CurrentYearStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'leave_use': _leaveUse,
        'leave_date': _leaveDate?.map((e) => e.toMap()).toList(),
        'leave_limit': _leaveLimit,
        'leave_remain': _leaveRemain,
        'year': _year,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leave_use': serializeParam(
          _leaveUse,
          ParamType.String,
        ),
        'leave_date': serializeParam(
          _leaveDate,
          ParamType.DataStruct,
          isList: true,
        ),
        'leave_limit': serializeParam(
          _leaveLimit,
          ParamType.String,
        ),
        'leave_remain': serializeParam(
          _leaveRemain,
          ParamType.String,
        ),
        'year': serializeParam(
          _year,
          ParamType.String,
        ),
      }.withoutNulls;

  static CurrentYearStruct fromSerializableMap(Map<String, dynamic> data) =>
      CurrentYearStruct(
        leaveUse: deserializeParam(
          data['leave_use'],
          ParamType.String,
          false,
        ),
        leaveDate: deserializeStructParam<LeaveDateStruct>(
          data['leave_date'],
          ParamType.DataStruct,
          true,
          structBuilder: LeaveDateStruct.fromSerializableMap,
        ),
        leaveLimit: deserializeParam(
          data['leave_limit'],
          ParamType.String,
          false,
        ),
        leaveRemain: deserializeParam(
          data['leave_remain'],
          ParamType.String,
          false,
        ),
        year: deserializeParam(
          data['year'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CurrentYearStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CurrentYearStruct &&
        leaveUse == other.leaveUse &&
        listEquality.equals(leaveDate, other.leaveDate) &&
        leaveLimit == other.leaveLimit &&
        leaveRemain == other.leaveRemain &&
        year == other.year;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([leaveUse, leaveDate, leaveLimit, leaveRemain, year]);
}

CurrentYearStruct createCurrentYearStruct({
  String? leaveUse,
  String? leaveLimit,
  String? leaveRemain,
  String? year,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CurrentYearStruct(
      leaveUse: leaveUse,
      leaveLimit: leaveLimit,
      leaveRemain: leaveRemain,
      year: year,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CurrentYearStruct? updateCurrentYearStruct(
  CurrentYearStruct? currentYear, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    currentYear
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCurrentYearStructData(
  Map<String, dynamic> firestoreData,
  CurrentYearStruct? currentYear,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (currentYear == null) {
    return;
  }
  if (currentYear.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && currentYear.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final currentYearData =
      getCurrentYearFirestoreData(currentYear, forFieldValue);
  final nestedData =
      currentYearData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = currentYear.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCurrentYearFirestoreData(
  CurrentYearStruct? currentYear, [
  bool forFieldValue = false,
]) {
  if (currentYear == null) {
    return {};
  }
  final firestoreData = mapToFirestore(currentYear.toMap());

  // Add any Firestore field values
  currentYear.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCurrentYearListFirestoreData(
  List<CurrentYearStruct>? currentYears,
) =>
    currentYears?.map((e) => getCurrentYearFirestoreData(e, true)).toList() ??
    [];
