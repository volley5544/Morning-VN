// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NextYearStruct extends FFFirebaseStruct {
  NextYearStruct({
    String? leaveUse,
    String? leaveLimit,
    String? leaveRemain,
    List<String>? leaveDate,
    String? year,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveUse = leaveUse,
        _leaveLimit = leaveLimit,
        _leaveRemain = leaveRemain,
        _leaveDate = leaveDate,
        _year = year,
        super(firestoreUtilData);

  // "leave_use" field.
  String? _leaveUse;
  String get leaveUse => _leaveUse ?? '';
  set leaveUse(String? val) => _leaveUse = val;

  bool hasLeaveUse() => _leaveUse != null;

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

  // "leave_date" field.
  List<String>? _leaveDate;
  List<String> get leaveDate => _leaveDate ?? const [];
  set leaveDate(List<String>? val) => _leaveDate = val;

  void updateLeaveDate(Function(List<String>) updateFn) {
    updateFn(_leaveDate ??= []);
  }

  bool hasLeaveDate() => _leaveDate != null;

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  set year(String? val) => _year = val;

  bool hasYear() => _year != null;

  static NextYearStruct fromMap(Map<String, dynamic> data) => NextYearStruct(
        leaveUse: data['leave_use'] as String?,
        leaveLimit: data['leave_limit'] as String?,
        leaveRemain: data['leave_remain'] as String?,
        leaveDate: getDataList(data['leave_date']),
        year: data['year'] as String?,
      );

  static NextYearStruct? maybeFromMap(dynamic data) =>
      data is Map ? NextYearStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'leave_use': _leaveUse,
        'leave_limit': _leaveLimit,
        'leave_remain': _leaveRemain,
        'leave_date': _leaveDate,
        'year': _year,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leave_use': serializeParam(
          _leaveUse,
          ParamType.String,
        ),
        'leave_limit': serializeParam(
          _leaveLimit,
          ParamType.String,
        ),
        'leave_remain': serializeParam(
          _leaveRemain,
          ParamType.String,
        ),
        'leave_date': serializeParam(
          _leaveDate,
          ParamType.String,
          isList: true,
        ),
        'year': serializeParam(
          _year,
          ParamType.String,
        ),
      }.withoutNulls;

  static NextYearStruct fromSerializableMap(Map<String, dynamic> data) =>
      NextYearStruct(
        leaveUse: deserializeParam(
          data['leave_use'],
          ParamType.String,
          false,
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
        leaveDate: deserializeParam<String>(
          data['leave_date'],
          ParamType.String,
          true,
        ),
        year: deserializeParam(
          data['year'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NextYearStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NextYearStruct &&
        leaveUse == other.leaveUse &&
        leaveLimit == other.leaveLimit &&
        leaveRemain == other.leaveRemain &&
        listEquality.equals(leaveDate, other.leaveDate) &&
        year == other.year;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([leaveUse, leaveLimit, leaveRemain, leaveDate, year]);
}

NextYearStruct createNextYearStruct({
  String? leaveUse,
  String? leaveLimit,
  String? leaveRemain,
  String? year,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NextYearStruct(
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

NextYearStruct? updateNextYearStruct(
  NextYearStruct? nextYear, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nextYear
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNextYearStructData(
  Map<String, dynamic> firestoreData,
  NextYearStruct? nextYear,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nextYear == null) {
    return;
  }
  if (nextYear.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nextYear.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nextYearData = getNextYearFirestoreData(nextYear, forFieldValue);
  final nestedData = nextYearData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nextYear.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNextYearFirestoreData(
  NextYearStruct? nextYear, [
  bool forFieldValue = false,
]) {
  if (nextYear == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nextYear.toMap());

  // Add any Firestore field values
  mapToFirestore(nextYear.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNextYearListFirestoreData(
  List<NextYearStruct>? nextYears,
) =>
    nextYears?.map((e) => getNextYearFirestoreData(e, true)).toList() ?? [];
