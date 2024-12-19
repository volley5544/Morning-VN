// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LeaveTypeDataStruct extends FFFirebaseStruct {
  LeaveTypeDataStruct({
    String? name,
    String? leaveType,
    String? startDate,
    String? endDate,
    List<AllLeaveListStruct>? allLeaveList,
    String? color,
    String? icon,
    CurrentYearStruct? currentYear,
    NextYearStruct? nextYear,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _leaveType = leaveType,
        _startDate = startDate,
        _endDate = endDate,
        _allLeaveList = allLeaveList,
        _color = color,
        _icon = icon,
        _currentYear = currentYear,
        _nextYear = nextYear,
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

  // "current_year" field.
  CurrentYearStruct? _currentYear;
  CurrentYearStruct get currentYear => _currentYear ?? CurrentYearStruct();
  set currentYear(CurrentYearStruct? val) => _currentYear = val;

  void updateCurrentYear(Function(CurrentYearStruct) updateFn) {
    updateFn(_currentYear ??= CurrentYearStruct());
  }

  bool hasCurrentYear() => _currentYear != null;

  // "next_year" field.
  NextYearStruct? _nextYear;
  NextYearStruct get nextYear => _nextYear ?? NextYearStruct();
  set nextYear(NextYearStruct? val) => _nextYear = val;

  void updateNextYear(Function(NextYearStruct) updateFn) {
    updateFn(_nextYear ??= NextYearStruct());
  }

  bool hasNextYear() => _nextYear != null;

  static LeaveTypeDataStruct fromMap(Map<String, dynamic> data) =>
      LeaveTypeDataStruct(
        name: data['name'] as String?,
        leaveType: data['leave_type'] as String?,
        startDate: data['start_date'] as String?,
        endDate: data['end_date'] as String?,
        allLeaveList: getStructList(
          data['all_leave_list'],
          AllLeaveListStruct.fromMap,
        ),
        color: data['color'] as String?,
        icon: data['icon'] as String?,
        currentYear: data['current_year'] is CurrentYearStruct
            ? data['current_year']
            : CurrentYearStruct.maybeFromMap(data['current_year']),
        nextYear: data['next_year'] is NextYearStruct
            ? data['next_year']
            : NextYearStruct.maybeFromMap(data['next_year']),
      );

  static LeaveTypeDataStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveTypeDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'leave_type': _leaveType,
        'start_date': _startDate,
        'end_date': _endDate,
        'all_leave_list': _allLeaveList?.map((e) => e.toMap()).toList(),
        'color': _color,
        'icon': _icon,
        'current_year': _currentYear?.toMap(),
        'next_year': _nextYear?.toMap(),
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
        'current_year': serializeParam(
          _currentYear,
          ParamType.DataStruct,
        ),
        'next_year': serializeParam(
          _nextYear,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static LeaveTypeDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveTypeDataStruct(
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
        currentYear: deserializeStructParam(
          data['current_year'],
          ParamType.DataStruct,
          false,
          structBuilder: CurrentYearStruct.fromSerializableMap,
        ),
        nextYear: deserializeStructParam(
          data['next_year'],
          ParamType.DataStruct,
          false,
          structBuilder: NextYearStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'LeaveTypeDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LeaveTypeDataStruct &&
        name == other.name &&
        leaveType == other.leaveType &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        listEquality.equals(allLeaveList, other.allLeaveList) &&
        color == other.color &&
        icon == other.icon &&
        currentYear == other.currentYear &&
        nextYear == other.nextYear;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        leaveType,
        startDate,
        endDate,
        allLeaveList,
        color,
        icon,
        currentYear,
        nextYear
      ]);
}

LeaveTypeDataStruct createLeaveTypeDataStruct({
  String? name,
  String? leaveType,
  String? startDate,
  String? endDate,
  String? color,
  String? icon,
  CurrentYearStruct? currentYear,
  NextYearStruct? nextYear,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LeaveTypeDataStruct(
      name: name,
      leaveType: leaveType,
      startDate: startDate,
      endDate: endDate,
      color: color,
      icon: icon,
      currentYear:
          currentYear ?? (clearUnsetFields ? CurrentYearStruct() : null),
      nextYear: nextYear ?? (clearUnsetFields ? NextYearStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LeaveTypeDataStruct? updateLeaveTypeDataStruct(
  LeaveTypeDataStruct? leaveTypeData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    leaveTypeData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLeaveTypeDataStructData(
  Map<String, dynamic> firestoreData,
  LeaveTypeDataStruct? leaveTypeData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (leaveTypeData == null) {
    return;
  }
  if (leaveTypeData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && leaveTypeData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final leaveTypeDataData =
      getLeaveTypeDataFirestoreData(leaveTypeData, forFieldValue);
  final nestedData =
      leaveTypeDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = leaveTypeData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLeaveTypeDataFirestoreData(
  LeaveTypeDataStruct? leaveTypeData, [
  bool forFieldValue = false,
]) {
  if (leaveTypeData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(leaveTypeData.toMap());

  // Handle nested data for "current_year" field.
  addCurrentYearStructData(
    firestoreData,
    leaveTypeData.hasCurrentYear() ? leaveTypeData.currentYear : null,
    'current_year',
    forFieldValue,
  );

  // Handle nested data for "next_year" field.
  addNextYearStructData(
    firestoreData,
    leaveTypeData.hasNextYear() ? leaveTypeData.nextYear : null,
    'next_year',
    forFieldValue,
  );

  // Add any Firestore field values
  leaveTypeData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLeaveTypeDataListFirestoreData(
  List<LeaveTypeDataStruct>? leaveTypeDatas,
) =>
    leaveTypeDatas
        ?.map((e) => getLeaveTypeDataFirestoreData(e, true))
        .toList() ??
    [];
