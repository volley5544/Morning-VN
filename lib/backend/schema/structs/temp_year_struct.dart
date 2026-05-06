// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TempYearStruct extends FFFirebaseStruct {
  TempYearStruct({
    String? leaveUse,
    List<LeaveDateStruct>? leaveDate,
    String? year,
    String? leaveLimit,
    String? leaveRemain,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveUse = leaveUse,
        _leaveDate = leaveDate,
        _year = year,
        _leaveLimit = leaveLimit,
        _leaveRemain = leaveRemain,
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

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  set year(String? val) => _year = val;

  bool hasYear() => _year != null;

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

  static TempYearStruct fromMap(Map<String, dynamic> data) => TempYearStruct(
        leaveUse: data['leave_use'] as String?,
        leaveDate: getStructList(
          data['leave_date'],
          LeaveDateStruct.fromMap,
        ),
        year: data['year'] as String?,
        leaveLimit: data['leave_limit'] as String?,
        leaveRemain: data['leave_remain'] as String?,
      );

  static TempYearStruct? maybeFromMap(dynamic data) =>
      data is Map ? TempYearStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'leave_use': _leaveUse,
        'leave_date': _leaveDate?.map((e) => e.toMap()).toList(),
        'year': _year,
        'leave_limit': _leaveLimit,
        'leave_remain': _leaveRemain,
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
        'year': serializeParam(
          _year,
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
      }.withoutNulls;

  static TempYearStruct fromSerializableMap(Map<String, dynamic> data) =>
      TempYearStruct(
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
        year: deserializeParam(
          data['year'],
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
      );

  @override
  String toString() => 'TempYearStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TempYearStruct &&
        leaveUse == other.leaveUse &&
        listEquality.equals(leaveDate, other.leaveDate) &&
        year == other.year &&
        leaveLimit == other.leaveLimit &&
        leaveRemain == other.leaveRemain;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([leaveUse, leaveDate, year, leaveLimit, leaveRemain]);
}

TempYearStruct createTempYearStruct({
  String? leaveUse,
  String? year,
  String? leaveLimit,
  String? leaveRemain,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TempYearStruct(
      leaveUse: leaveUse,
      year: year,
      leaveLimit: leaveLimit,
      leaveRemain: leaveRemain,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TempYearStruct? updateTempYearStruct(
  TempYearStruct? tempYear, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tempYear
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTempYearStructData(
  Map<String, dynamic> firestoreData,
  TempYearStruct? tempYear,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tempYear == null) {
    return;
  }
  if (tempYear.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tempYear.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tempYearData = getTempYearFirestoreData(tempYear, forFieldValue);
  final nestedData = tempYearData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tempYear.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTempYearFirestoreData(
  TempYearStruct? tempYear, [
  bool forFieldValue = false,
]) {
  if (tempYear == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tempYear.toMap());

  // Add any Firestore field values
  mapToFirestore(tempYear.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTempYearListFirestoreData(
  List<TempYearStruct>? tempYears,
) =>
    tempYears?.map((e) => getTempYearFirestoreData(e, true)).toList() ?? [];
