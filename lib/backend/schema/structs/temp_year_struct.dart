// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TempYearStruct extends FFFirebaseStruct {
  TempYearStruct({
    int? leaveUse,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _leaveUse = leaveUse,
        super(firestoreUtilData);

  // "leave_use" field.
  int? _leaveUse;
  int get leaveUse => _leaveUse ?? 0;
  set leaveUse(int? val) => _leaveUse = val;

  void incrementLeaveUse(int amount) => leaveUse = leaveUse + amount;

  bool hasLeaveUse() => _leaveUse != null;

  static TempYearStruct fromMap(Map<String, dynamic> data) => TempYearStruct(
        leaveUse: castToType<int>(data['leave_use']),
      );

  static TempYearStruct? maybeFromMap(dynamic data) =>
      data is Map ? TempYearStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'leave_use': _leaveUse,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leave_use': serializeParam(
          _leaveUse,
          ParamType.int,
        ),
      }.withoutNulls;

  static TempYearStruct fromSerializableMap(Map<String, dynamic> data) =>
      TempYearStruct(
        leaveUse: deserializeParam(
          data['leave_use'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TempYearStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TempYearStruct && leaveUse == other.leaveUse;
  }

  @override
  int get hashCode => const ListEquality().hash([leaveUse]);
}

TempYearStruct createTempYearStruct({
  int? leaveUse,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TempYearStruct(
      leaveUse: leaveUse,
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
  tempYear.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTempYearListFirestoreData(
  List<TempYearStruct>? tempYears,
) =>
    tempYears?.map((e) => getTempYearFirestoreData(e, true)).toList() ?? [];
