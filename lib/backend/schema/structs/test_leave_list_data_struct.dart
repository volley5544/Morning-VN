// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TestLeaveListDataStruct extends FFFirebaseStruct {
  TestLeaveListDataStruct({
    String? name,
    String? leaveType,
    CurrentYearStruct? currentYear,
    OtherYearStruct? otherYear,
    TempYearStruct? tempYear,
    String? startDate,
    String? endDate,
    List<AllLeaveListStruct>? allLeaveList,
    String? color,
    String? icon,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _leaveType = leaveType,
        _currentYear = currentYear,
        _otherYear = otherYear,
        _tempYear = tempYear,
        _startDate = startDate,
        _endDate = endDate,
        _allLeaveList = allLeaveList,
        _color = color,
        _icon = icon,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "leave_type" field.
  String? _leaveType;
  String get leaveType => _leaveType ?? '';
  set leaveType(String? val) => _leaveType = val;

  bool hasLeaveType() => _leaveType != null;

  // "current_year" field.
  CurrentYearStruct? _currentYear;
  CurrentYearStruct get currentYear => _currentYear ?? CurrentYearStruct();
  set currentYear(CurrentYearStruct? val) => _currentYear = val;

  void updateCurrentYear(Function(CurrentYearStruct) updateFn) {
    updateFn(_currentYear ??= CurrentYearStruct());
  }

  bool hasCurrentYear() => _currentYear != null;

  // "other_year" field.
  OtherYearStruct? _otherYear;
  OtherYearStruct get otherYear => _otherYear ?? OtherYearStruct();
  set otherYear(OtherYearStruct? val) => _otherYear = val;

  void updateOtherYear(Function(OtherYearStruct) updateFn) {
    updateFn(_otherYear ??= OtherYearStruct());
  }

  bool hasOtherYear() => _otherYear != null;

  // "temp_year" field.
  TempYearStruct? _tempYear;
  TempYearStruct get tempYear => _tempYear ?? TempYearStruct();
  set tempYear(TempYearStruct? val) => _tempYear = val;

  void updateTempYear(Function(TempYearStruct) updateFn) {
    updateFn(_tempYear ??= TempYearStruct());
  }

  bool hasTempYear() => _tempYear != null;

  // "start_date" field.
  String? _startDate;
  String get startDate => _startDate ?? '';
  set startDate(String? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  // "all_leave_list" field.
  List<AllLeaveListStruct>? _allLeaveList;
  List<AllLeaveListStruct> get allLeaveList => _allLeaveList ?? const [];
  set allLeaveList(List<AllLeaveListStruct>? val) => _allLeaveList = val;

  void updateAllLeaveList(Function(List<AllLeaveListStruct>) updateFn) {
    updateFn(_allLeaveList ??= []);
  }

  bool hasAllLeaveList() => _allLeaveList != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  set icon(String? val) => _icon = val;

  bool hasIcon() => _icon != null;

  static TestLeaveListDataStruct fromMap(Map<String, dynamic> data) =>
      TestLeaveListDataStruct(
        name: data['name'] as String?,
        leaveType: data['leave_type'] as String?,
        currentYear: data['current_year'] is CurrentYearStruct
            ? data['current_year']
            : CurrentYearStruct.maybeFromMap(data['current_year']),
        otherYear: data['other_year'] is OtherYearStruct
            ? data['other_year']
            : OtherYearStruct.maybeFromMap(data['other_year']),
        tempYear: data['temp_year'] is TempYearStruct
            ? data['temp_year']
            : TempYearStruct.maybeFromMap(data['temp_year']),
        startDate: data['start_date'] as String?,
        endDate: data['end_date'] as String?,
        allLeaveList: getStructList(
          data['all_leave_list'],
          AllLeaveListStruct.fromMap,
        ),
        color: data['color'] as String?,
        icon: data['icon'] as String?,
      );

  static TestLeaveListDataStruct? maybeFromMap(dynamic data) => data is Map
      ? TestLeaveListDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'leave_type': _leaveType,
        'current_year': _currentYear?.toMap(),
        'other_year': _otherYear?.toMap(),
        'temp_year': _tempYear?.toMap(),
        'start_date': _startDate,
        'end_date': _endDate,
        'all_leave_list': _allLeaveList?.map((e) => e.toMap()).toList(),
        'color': _color,
        'icon': _icon,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'leave_type': serializeParam(
          _leaveType,
          ParamType.String,
        ),
        'current_year': serializeParam(
          _currentYear,
          ParamType.DataStruct,
        ),
        'other_year': serializeParam(
          _otherYear,
          ParamType.DataStruct,
        ),
        'temp_year': serializeParam(
          _tempYear,
          ParamType.DataStruct,
        ),
        'start_date': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'end_date': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'all_leave_list': serializeParam(
          _allLeaveList,
          ParamType.DataStruct,
          isList: true,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'icon': serializeParam(
          _icon,
          ParamType.String,
        ),
      }.withoutNulls;

  static TestLeaveListDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TestLeaveListDataStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        leaveType: deserializeParam(
          data['leave_type'],
          ParamType.String,
          false,
        ),
        currentYear: deserializeStructParam(
          data['current_year'],
          ParamType.DataStruct,
          false,
          structBuilder: CurrentYearStruct.fromSerializableMap,
        ),
        otherYear: deserializeStructParam(
          data['other_year'],
          ParamType.DataStruct,
          false,
          structBuilder: OtherYearStruct.fromSerializableMap,
        ),
        tempYear: deserializeStructParam(
          data['temp_year'],
          ParamType.DataStruct,
          false,
          structBuilder: TempYearStruct.fromSerializableMap,
        ),
        startDate: deserializeParam(
          data['start_date'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['end_date'],
          ParamType.String,
          false,
        ),
        allLeaveList: deserializeStructParam<AllLeaveListStruct>(
          data['all_leave_list'],
          ParamType.DataStruct,
          true,
          structBuilder: AllLeaveListStruct.fromSerializableMap,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        icon: deserializeParam(
          data['icon'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TestLeaveListDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TestLeaveListDataStruct &&
        name == other.name &&
        leaveType == other.leaveType &&
        currentYear == other.currentYear &&
        otherYear == other.otherYear &&
        tempYear == other.tempYear &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        listEquality.equals(allLeaveList, other.allLeaveList) &&
        color == other.color &&
        icon == other.icon;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        leaveType,
        currentYear,
        otherYear,
        tempYear,
        startDate,
        endDate,
        allLeaveList,
        color,
        icon
      ]);
}

TestLeaveListDataStruct createTestLeaveListDataStruct({
  String? name,
  String? leaveType,
  CurrentYearStruct? currentYear,
  OtherYearStruct? otherYear,
  TempYearStruct? tempYear,
  String? startDate,
  String? endDate,
  String? color,
  String? icon,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TestLeaveListDataStruct(
      name: name,
      leaveType: leaveType,
      currentYear:
          currentYear ?? (clearUnsetFields ? CurrentYearStruct() : null),
      otherYear: otherYear ?? (clearUnsetFields ? OtherYearStruct() : null),
      tempYear: tempYear ?? (clearUnsetFields ? TempYearStruct() : null),
      startDate: startDate,
      endDate: endDate,
      color: color,
      icon: icon,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TestLeaveListDataStruct? updateTestLeaveListDataStruct(
  TestLeaveListDataStruct? testLeaveListData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    testLeaveListData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTestLeaveListDataStructData(
  Map<String, dynamic> firestoreData,
  TestLeaveListDataStruct? testLeaveListData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (testLeaveListData == null) {
    return;
  }
  if (testLeaveListData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && testLeaveListData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final testLeaveListDataData =
      getTestLeaveListDataFirestoreData(testLeaveListData, forFieldValue);
  final nestedData =
      testLeaveListDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = testLeaveListData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTestLeaveListDataFirestoreData(
  TestLeaveListDataStruct? testLeaveListData, [
  bool forFieldValue = false,
]) {
  if (testLeaveListData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(testLeaveListData.toMap());

  // Handle nested data for "current_year" field.
  addCurrentYearStructData(
    firestoreData,
    testLeaveListData.hasCurrentYear() ? testLeaveListData.currentYear : null,
    'current_year',
    forFieldValue,
  );

  // Handle nested data for "other_year" field.
  addOtherYearStructData(
    firestoreData,
    testLeaveListData.hasOtherYear() ? testLeaveListData.otherYear : null,
    'other_year',
    forFieldValue,
  );

  // Handle nested data for "temp_year" field.
  addTempYearStructData(
    firestoreData,
    testLeaveListData.hasTempYear() ? testLeaveListData.tempYear : null,
    'temp_year',
    forFieldValue,
  );

  // Add any Firestore field values
  testLeaveListData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTestLeaveListDataListFirestoreData(
  List<TestLeaveListDataStruct>? testLeaveListDatas,
) =>
    testLeaveListDatas
        ?.map((e) => getTestLeaveListDataFirestoreData(e, true))
        .toList() ??
    [];
