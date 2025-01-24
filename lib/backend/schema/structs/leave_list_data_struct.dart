// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LeaveListDataStruct extends FFFirebaseStruct {
  LeaveListDataStruct({
    String? name,
    String? leaveType,
    CurrentYearStruct? currentYear,
    String? startDate,
    String? endDate,
    List<AllLeaveListStruct>? allLeaveList,
    String? color,
    String? icon,
    TempYearStruct? tempYear,
    TempYearStruct? ontherYear,
    List<LeavePeriodStruct>? leavePeriod,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _leaveType = leaveType,
        _currentYear = currentYear,
        _startDate = startDate,
        _endDate = endDate,
        _allLeaveList = allLeaveList,
        _color = color,
        _icon = icon,
        _tempYear = tempYear,
        _ontherYear = ontherYear,
        _leavePeriod = leavePeriod,
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

  // "temp_year" field.
  TempYearStruct? _tempYear;
  TempYearStruct get tempYear => _tempYear ?? TempYearStruct();
  set tempYear(TempYearStruct? val) => _tempYear = val;

  void updateTempYear(Function(TempYearStruct) updateFn) {
    updateFn(_tempYear ??= TempYearStruct());
  }

  bool hasTempYear() => _tempYear != null;

  // "onther_year" field.
  TempYearStruct? _ontherYear;
  TempYearStruct get ontherYear => _ontherYear ?? TempYearStruct();
  set ontherYear(TempYearStruct? val) => _ontherYear = val;

  void updateOntherYear(Function(TempYearStruct) updateFn) {
    updateFn(_ontherYear ??= TempYearStruct());
  }

  bool hasOntherYear() => _ontherYear != null;

  // "leave_period" field.
  List<LeavePeriodStruct>? _leavePeriod;
  List<LeavePeriodStruct> get leavePeriod => _leavePeriod ?? const [];
  set leavePeriod(List<LeavePeriodStruct>? val) => _leavePeriod = val;

  void updateLeavePeriod(Function(List<LeavePeriodStruct>) updateFn) {
    updateFn(_leavePeriod ??= []);
  }

  bool hasLeavePeriod() => _leavePeriod != null;

  static LeaveListDataStruct fromMap(Map<String, dynamic> data) =>
      LeaveListDataStruct(
        name: data['name'] as String?,
        leaveType: data['leave_type'] as String?,
        currentYear: data['current_year'] is CurrentYearStruct
            ? data['current_year']
            : CurrentYearStruct.maybeFromMap(data['current_year']),
        startDate: data['start_date'] as String?,
        endDate: data['end_date'] as String?,
        allLeaveList: getStructList(
          data['all_leave_list'],
          AllLeaveListStruct.fromMap,
        ),
        color: data['color'] as String?,
        icon: data['icon'] as String?,
        tempYear: data['temp_year'] is TempYearStruct
            ? data['temp_year']
            : TempYearStruct.maybeFromMap(data['temp_year']),
        ontherYear: data['onther_year'] is TempYearStruct
            ? data['onther_year']
            : TempYearStruct.maybeFromMap(data['onther_year']),
        leavePeriod: getStructList(
          data['leave_period'],
          LeavePeriodStruct.fromMap,
        ),
      );

  static LeaveListDataStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveListDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'leave_type': _leaveType,
        'current_year': _currentYear?.toMap(),
        'start_date': _startDate,
        'end_date': _endDate,
        'all_leave_list': _allLeaveList?.map((e) => e.toMap()).toList(),
        'color': _color,
        'icon': _icon,
        'temp_year': _tempYear?.toMap(),
        'onther_year': _ontherYear?.toMap(),
        'leave_period': _leavePeriod?.map((e) => e.toMap()).toList(),
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
        'temp_year': serializeParam(
          _tempYear,
          ParamType.DataStruct,
        ),
        'onther_year': serializeParam(
          _ontherYear,
          ParamType.DataStruct,
        ),
        'leave_period': serializeParam(
          _leavePeriod,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static LeaveListDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveListDataStruct(
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
        tempYear: deserializeStructParam(
          data['temp_year'],
          ParamType.DataStruct,
          false,
          structBuilder: TempYearStruct.fromSerializableMap,
        ),
        ontherYear: deserializeStructParam(
          data['onther_year'],
          ParamType.DataStruct,
          false,
          structBuilder: TempYearStruct.fromSerializableMap,
        ),
        leavePeriod: deserializeStructParam<LeavePeriodStruct>(
          data['leave_period'],
          ParamType.DataStruct,
          true,
          structBuilder: LeavePeriodStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'LeaveListDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LeaveListDataStruct &&
        name == other.name &&
        leaveType == other.leaveType &&
        currentYear == other.currentYear &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        listEquality.equals(allLeaveList, other.allLeaveList) &&
        color == other.color &&
        icon == other.icon &&
        tempYear == other.tempYear &&
        ontherYear == other.ontherYear &&
        listEquality.equals(leavePeriod, other.leavePeriod);
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        leaveType,
        currentYear,
        startDate,
        endDate,
        allLeaveList,
        color,
        icon,
        tempYear,
        ontherYear,
        leavePeriod
      ]);
}

LeaveListDataStruct createLeaveListDataStruct({
  String? name,
  String? leaveType,
  CurrentYearStruct? currentYear,
  String? startDate,
  String? endDate,
  String? color,
  String? icon,
  TempYearStruct? tempYear,
  TempYearStruct? ontherYear,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveListDataStruct(
      name: name,
      leaveType: leaveType,
      currentYear:
          currentYear ?? (clearUnsetFields ? CurrentYearStruct() : null),
      startDate: startDate,
      endDate: endDate,
      color: color,
      icon: icon,
      tempYear: tempYear ?? (clearUnsetFields ? TempYearStruct() : null),
      ontherYear: ontherYear ?? (clearUnsetFields ? TempYearStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeaveListDataStruct? updateLeaveListDataStruct(
  LeaveListDataStruct? leaveListData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveListData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveListDataStructData(
  Map<String, dynamic> firestoreData,
  LeaveListDataStruct? leaveListData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveListData == null) {
    return;
  }
  if (leaveListData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveListData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveListDataData =
      getLeaveListDataFirestoreData(leaveListData, forFieldValue);
  final nestedData =
      leaveListDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveListData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveListDataFirestoreData(
  LeaveListDataStruct? leaveListData, [
  bool forFieldValue = false,
]) {
  if (leaveListData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveListData.toMap());

  // Handle nested data for "current_year" field.
  addCurrentYearStructData(
    firestoreData,
    leaveListData.hasCurrentYear() ? leaveListData.currentYear : null,
    'current_year',
    forFieldValue,
  );

  // Handle nested data for "temp_year" field.
  addTempYearStructData(
    firestoreData,
    leaveListData.hasTempYear() ? leaveListData.tempYear : null,
    'temp_year',
    forFieldValue,
  );

  // Handle nested data for "onther_year" field.
  addTempYearStructData(
    firestoreData,
    leaveListData.hasOntherYear() ? leaveListData.ontherYear : null,
    'onther_year',
    forFieldValue,
  );

  // Add any Firestore field values
  leaveListData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveListDataListFirestoreData(
  List<LeaveListDataStruct>? leaveListDatas,
) =>
    leaveListDatas
        ?.map((e) => getLeaveListDataFirestoreData(e, true))
        .toList() ??
    [];
