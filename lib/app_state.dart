import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _accessToken = prefs.getString('ff_accessToken') ?? _accessToken;
    });
    _safeInit(() {
      _pinCode = prefs.getString('ff_pinCode') ?? _pinCode;
    });
    _safeInit(() {
      _username = prefs.getString('ff_username') ?? _username;
    });
    _safeInit(() {
      _employeeID = prefs.getString('ff_employeeID') ?? _employeeID;
    });
    _safeInit(() {
      _brachListNew = prefs.getStringList('ff_brachListNew') ?? _brachListNew;
    });
    _safeInit(() {
      _brachGroupNew = prefs.getString('ff_brachGroupNew') ?? _brachGroupNew;
    });
    _safeInit(() {
      _firstLoginLocation =
          latLngFromString(prefs.getString('ff_firstLoginLocation')) ??
              _firstLoginLocation;
    });
    _safeInit(() {
      _userRef = prefs.getString('ff_userRef')?.ref ?? _userRef;
    });
    _safeInit(() {
      _userRefDoc = prefs.getString('ff_userRefDoc') ?? _userRefDoc;
    });
    _safeInit(() {
      _appLanguage = prefs.getString('ff_appLanguage') ?? _appLanguage;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
    prefs.setString('ff_accessToken', value);
  }

  String _apiUrlAppState = 'http://dev-vn.swpfin.com:8086';
  String get apiUrlAppState => _apiUrlAppState;
  set apiUrlAppState(String value) {
    _apiUrlAppState = value;
  }

  bool _fromPinPage = false;
  bool get fromPinPage => _fromPinPage;
  set fromPinPage(bool value) {
    _fromPinPage = value;
  }

  String _pinCode = '';
  String get pinCode => _pinCode;
  set pinCode(String value) {
    _pinCode = value;
    prefs.setString('ff_pinCode', value);
  }

  bool _fromSetPin = false;
  bool get fromSetPin => _fromSetPin;
  set fromSetPin(bool value) {
    _fromSetPin = value;
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool value) {
    _isLogin = value;
  }

  String _username = '';
  String get username => _username;
  set username(String value) {
    _username = value;
    prefs.setString('ff_username', value);
  }

  List<String> _defaultList = ['Hello World1', 'Hello World2', 'Hello World3'];
  List<String> get defaultList => _defaultList;
  set defaultList(List<String> value) {
    _defaultList = value;
  }

  void addToDefaultList(String value) {
    defaultList.add(value);
  }

  void removeFromDefaultList(String value) {
    defaultList.remove(value);
  }

  void removeAtIndexFromDefaultList(int index) {
    defaultList.removeAt(index);
  }

  void updateDefaultListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    defaultList[index] = updateFn(_defaultList[index]);
  }

  void insertAtIndexInDefaultList(int index, String value) {
    defaultList.insert(index, value);
  }

  List<String> _defaultList2 = [
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World',
    'Hello World'
  ];
  List<String> get defaultList2 => _defaultList2;
  set defaultList2(List<String> value) {
    _defaultList2 = value;
  }

  void addToDefaultList2(String value) {
    defaultList2.add(value);
  }

  void removeFromDefaultList2(String value) {
    defaultList2.remove(value);
  }

  void removeAtIndexFromDefaultList2(int index) {
    defaultList2.removeAt(index);
  }

  void updateDefaultList2AtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    defaultList2[index] = updateFn(_defaultList2[index]);
  }

  void insertAtIndexInDefaultList2(int index, String value) {
    defaultList2.insert(index, value);
  }

  String _employeeID = '';
  String get employeeID => _employeeID;
  set employeeID(String value) {
    _employeeID = value;
    prefs.setString('ff_employeeID', value);
  }

  DocumentReference? _applicationConfigDocRef =
      FirebaseFirestore.instance.doc('/ApplicationConfig/nXAvCNHjWBswm9fqm4FX');
  DocumentReference? get applicationConfigDocRef => _applicationConfigDocRef;
  set applicationConfigDocRef(DocumentReference? value) {
    _applicationConfigDocRef = value;
  }

  String _imgURLTemp = '';
  String get imgURLTemp => _imgURLTemp;
  set imgURLTemp(String value) {
    _imgURLTemp = value;
  }

  String _profilePositionName = '';
  String get profilePositionName => _profilePositionName;
  set profilePositionName(String value) {
    _profilePositionName = value;
  }

  String _profileStartDate = '';
  String get profileStartDate => _profileStartDate;
  set profileStartDate(String value) {
    _profileStartDate = value;
  }

  String _branchCode = '';
  String get branchCode => _branchCode;
  set branchCode(String value) {
    _branchCode = value;
  }

  List<String> _brachListNew = [];
  List<String> get brachListNew => _brachListNew;
  set brachListNew(List<String> value) {
    _brachListNew = value;
    prefs.setStringList('ff_brachListNew', value);
  }

  void addToBrachListNew(String value) {
    brachListNew.add(value);
    prefs.setStringList('ff_brachListNew', _brachListNew);
  }

  void removeFromBrachListNew(String value) {
    brachListNew.remove(value);
    prefs.setStringList('ff_brachListNew', _brachListNew);
  }

  void removeAtIndexFromBrachListNew(int index) {
    brachListNew.removeAt(index);
    prefs.setStringList('ff_brachListNew', _brachListNew);
  }

  void updateBrachListNewAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    brachListNew[index] = updateFn(_brachListNew[index]);
    prefs.setStringList('ff_brachListNew', _brachListNew);
  }

  void insertAtIndexInBrachListNew(int index, String value) {
    brachListNew.insert(index, value);
    prefs.setStringList('ff_brachListNew', _brachListNew);
  }

  String _brachGroupNew = '';
  String get brachGroupNew => _brachGroupNew;
  set brachGroupNew(String value) {
    _brachGroupNew = value;
    prefs.setString('ff_brachGroupNew', value);
  }

  LatLng? _firstLoginLocation;
  LatLng? get firstLoginLocation => _firstLoginLocation;
  set firstLoginLocation(LatLng? value) {
    _firstLoginLocation = value;
    value != null
        ? prefs.setString('ff_firstLoginLocation', value.serialize())
        : prefs.remove('ff_firstLoginLocation');
  }

  String _profileServiceDuration = '';
  String get profileServiceDuration => _profileServiceDuration;
  set profileServiceDuration(String value) {
    _profileServiceDuration = value;
  }

  String _profilePosisionAge = '';
  String get profilePosisionAge => _profilePosisionAge;
  set profilePosisionAge(String value) {
    _profilePosisionAge = value;
  }

  String _profilePositionAgeCheck = '[position_age_check]';
  String get profilePositionAgeCheck => _profilePositionAgeCheck;
  set profilePositionAgeCheck(String value) {
    _profilePositionAgeCheck = value;
  }

  String _branchLoString = '';
  String get branchLoString => _branchLoString;
  set branchLoString(String value) {
    _branchLoString = value;
  }

  bool _checkBranchDropdown = false;
  bool get checkBranchDropdown => _checkBranchDropdown;
  set checkBranchDropdown(bool value) {
    _checkBranchDropdown = value;
  }

  LatLng? _branchLo;
  LatLng? get branchLo => _branchLo;
  set branchLo(LatLng? value) {
    _branchLo = value;
  }

  double _currentRadius = 0.0;
  double get currentRadius => _currentRadius;
  set currentRadius(double value) {
    _currentRadius = value;
  }

  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? value) {
    _userRef = value;
    value != null
        ? prefs.setString('ff_userRef', value.path)
        : prefs.remove('ff_userRef');
  }

  String _userRefDoc = '';
  String get userRefDoc => _userRefDoc;
  set userRefDoc(String value) {
    _userRefDoc = value;
    prefs.setString('ff_userRefDoc', value);
  }

  String _branchRADIUS = '';
  String get branchRADIUS => _branchRADIUS;
  set branchRADIUS(String value) {
    _branchRADIUS = value;
  }

  List<String> _leaveHalfDay = ['full', 'half', 'half'];
  List<String> get leaveHalfDay => _leaveHalfDay;
  set leaveHalfDay(List<String> value) {
    _leaveHalfDay = value;
  }

  void addToLeaveHalfDay(String value) {
    leaveHalfDay.add(value);
  }

  void removeFromLeaveHalfDay(String value) {
    leaveHalfDay.remove(value);
  }

  void removeAtIndexFromLeaveHalfDay(int index) {
    leaveHalfDay.removeAt(index);
  }

  void updateLeaveHalfDayAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    leaveHalfDay[index] = updateFn(_leaveHalfDay[index]);
  }

  void insertAtIndexInLeaveHalfDay(int index, String value) {
    leaveHalfDay.insert(index, value);
  }

  List<String> _leaveFullDay = ['full'];
  List<String> get leaveFullDay => _leaveFullDay;
  set leaveFullDay(List<String> value) {
    _leaveFullDay = value;
  }

  void addToLeaveFullDay(String value) {
    leaveFullDay.add(value);
  }

  void removeFromLeaveFullDay(String value) {
    leaveFullDay.remove(value);
  }

  void removeAtIndexFromLeaveFullDay(int index) {
    leaveFullDay.removeAt(index);
  }

  void updateLeaveFullDayAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    leaveFullDay[index] = updateFn(_leaveFullDay[index]);
  }

  void insertAtIndexInLeaveFullDay(int index, String value) {
    leaveFullDay.insert(index, value);
  }

  bool _allowFileUpload = false;
  bool get allowFileUpload => _allowFileUpload;
  set allowFileUpload(bool value) {
    _allowFileUpload = value;
  }

  List<DateTime> _dateSelectedList = [];
  List<DateTime> get dateSelectedList => _dateSelectedList;
  set dateSelectedList(List<DateTime> value) {
    _dateSelectedList = value;
  }

  void addToDateSelectedList(DateTime value) {
    dateSelectedList.add(value);
  }

  void removeFromDateSelectedList(DateTime value) {
    dateSelectedList.remove(value);
  }

  void removeAtIndexFromDateSelectedList(int index) {
    dateSelectedList.removeAt(index);
  }

  void updateDateSelectedListAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    dateSelectedList[index] = updateFn(_dateSelectedList[index]);
  }

  void insertAtIndexInDateSelectedList(int index, DateTime value) {
    dateSelectedList.insert(index, value);
  }

  DateTime? _dateSelectedStart;
  DateTime? get dateSelectedStart => _dateSelectedStart;
  set dateSelectedStart(DateTime? value) {
    _dateSelectedStart = value;
  }

  DateTime? _dateSelectedEnd;
  DateTime? get dateSelectedEnd => _dateSelectedEnd;
  set dateSelectedEnd(DateTime? value) {
    _dateSelectedEnd = value;
  }

  int _indexBranchCheckin = -1;
  int get indexBranchCheckin => _indexBranchCheckin;
  set indexBranchCheckin(int value) {
    _indexBranchCheckin = value;
  }

  bool _isFromTimesheetPage = false;
  bool get isFromTimesheetPage => _isFromTimesheetPage;
  set isFromTimesheetPage(bool value) {
    _isFromTimesheetPage = value;
  }

  String _changeLng = '';
  String get changeLng => _changeLng;
  set changeLng(String value) {
    _changeLng = value;
  }

  String _changeLat = '';
  String get changeLat => _changeLat;
  set changeLat(String value) {
    _changeLat = value;
  }

  String _changeBranchCode = '';
  String get changeBranchCode => _changeBranchCode;
  set changeBranchCode(String value) {
    _changeBranchCode = value;
  }

  List<String> _holidayList = ['2024-12-10', '2024-12-25', '2024-12-31'];
  List<String> get holidayList => _holidayList;
  set holidayList(List<String> value) {
    _holidayList = value;
  }

  void addToHolidayList(String value) {
    holidayList.add(value);
  }

  void removeFromHolidayList(String value) {
    holidayList.remove(value);
  }

  void removeAtIndexFromHolidayList(int index) {
    holidayList.removeAt(index);
  }

  void updateHolidayListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    holidayList[index] = updateFn(_holidayList[index]);
  }

  void insertAtIndexInHolidayList(int index, String value) {
    holidayList.insert(index, value);
  }

  List<DateTime> _dateSelect = [];
  List<DateTime> get dateSelect => _dateSelect;
  set dateSelect(List<DateTime> value) {
    _dateSelect = value;
  }

  void addToDateSelect(DateTime value) {
    dateSelect.add(value);
  }

  void removeFromDateSelect(DateTime value) {
    dateSelect.remove(value);
  }

  void removeAtIndexFromDateSelect(int index) {
    dateSelect.removeAt(index);
  }

  void updateDateSelectAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    dateSelect[index] = updateFn(_dateSelect[index]);
  }

  void insertAtIndexInDateSelect(int index, DateTime value) {
    dateSelect.insert(index, value);
  }

  List<DateTime> _selectedDatesList = [];
  List<DateTime> get selectedDatesList => _selectedDatesList;
  set selectedDatesList(List<DateTime> value) {
    _selectedDatesList = value;
  }

  void addToSelectedDatesList(DateTime value) {
    selectedDatesList.add(value);
  }

  void removeFromSelectedDatesList(DateTime value) {
    selectedDatesList.remove(value);
  }

  void removeAtIndexFromSelectedDatesList(int index) {
    selectedDatesList.removeAt(index);
  }

  void updateSelectedDatesListAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    selectedDatesList[index] = updateFn(_selectedDatesList[index]);
  }

  void insertAtIndexInSelectedDatesList(int index, DateTime value) {
    selectedDatesList.insert(index, value);
  }

  List<String> _holidayList1 = [
    '2024-12-05',
    '2024-12-07',
    '2024-12-10',
    '2024-12-31',
    '2025-01-01'
  ];
  List<String> get holidayList1 => _holidayList1;
  set holidayList1(List<String> value) {
    _holidayList1 = value;
  }

  void addToHolidayList1(String value) {
    holidayList1.add(value);
  }

  void removeFromHolidayList1(String value) {
    holidayList1.remove(value);
  }

  void removeAtIndexFromHolidayList1(int index) {
    holidayList1.removeAt(index);
  }

  void updateHolidayList1AtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    holidayList1[index] = updateFn(_holidayList1[index]);
  }

  void insertAtIndexInHolidayList1(int index, String value) {
    holidayList1.insert(index, value);
  }

  String _ProfilePhoneNumber = '';
  String get ProfilePhoneNumber => _ProfilePhoneNumber;
  set ProfilePhoneNumber(String value) {
    _ProfilePhoneNumber = value;
  }

  int _leaveDays = 0;
  int get leaveDays => _leaveDays;
  set leaveDays(int value) {
    _leaveDays = value;
  }

  String _appLanguage = '';
  String get appLanguage => _appLanguage;
  set appLanguage(String value) {
    _appLanguage = value;
    prefs.setString('ff_appLanguage', value);
  }

  String _profileHiredDate = '';
  String get profileHiredDate => _profileHiredDate;
  set profileHiredDate(String value) {
    _profileHiredDate = value;
  }

  String _selectMonthViewLeaveShow = '';
  String get selectMonthViewLeaveShow => _selectMonthViewLeaveShow;
  set selectMonthViewLeaveShow(String value) {
    _selectMonthViewLeaveShow = value;
  }

  bool _multiApprove = false;
  bool get multiApprove => _multiApprove;
  set multiApprove(bool value) {
    _multiApprove = value;
  }

  List<bool> _selectApproveList = [];
  List<bool> get selectApproveList => _selectApproveList;
  set selectApproveList(List<bool> value) {
    _selectApproveList = value;
  }

  void addToSelectApproveList(bool value) {
    selectApproveList.add(value);
  }

  void removeFromSelectApproveList(bool value) {
    selectApproveList.remove(value);
  }

  void removeAtIndexFromSelectApproveList(int index) {
    selectApproveList.removeAt(index);
  }

  void updateSelectApproveListAtIndex(
    int index,
    bool Function(bool) updateFn,
  ) {
    selectApproveList[index] = updateFn(_selectApproveList[index]);
  }

  void insertAtIndexInSelectApproveList(int index, bool value) {
    selectApproveList.insert(index, value);
  }

  List<String> _leaveDocImgPathList = [];
  List<String> get leaveDocImgPathList => _leaveDocImgPathList;
  set leaveDocImgPathList(List<String> value) {
    _leaveDocImgPathList = value;
  }

  void addToLeaveDocImgPathList(String value) {
    leaveDocImgPathList.add(value);
  }

  void removeFromLeaveDocImgPathList(String value) {
    leaveDocImgPathList.remove(value);
  }

  void removeAtIndexFromLeaveDocImgPathList(int index) {
    leaveDocImgPathList.removeAt(index);
  }

  void updateLeaveDocImgPathListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    leaveDocImgPathList[index] = updateFn(_leaveDocImgPathList[index]);
  }

  void insertAtIndexInLeaveDocImgPathList(int index, String value) {
    leaveDocImgPathList.insert(index, value);
  }

  List<String> _leaveDocImgPathListNew = [];
  List<String> get leaveDocImgPathListNew => _leaveDocImgPathListNew;
  set leaveDocImgPathListNew(List<String> value) {
    _leaveDocImgPathListNew = value;
  }

  void addToLeaveDocImgPathListNew(String value) {
    leaveDocImgPathListNew.add(value);
  }

  void removeFromLeaveDocImgPathListNew(String value) {
    leaveDocImgPathListNew.remove(value);
  }

  void removeAtIndexFromLeaveDocImgPathListNew(int index) {
    leaveDocImgPathListNew.removeAt(index);
  }

  void updateLeaveDocImgPathListNewAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    leaveDocImgPathListNew[index] = updateFn(_leaveDocImgPathListNew[index]);
  }

  void insertAtIndexInLeaveDocImgPathListNew(int index, String value) {
    leaveDocImgPathListNew.insert(index, value);
  }

  String _selectYearViewLeaveShow = '';
  String get selectYearViewLeaveShow => _selectYearViewLeaveShow;
  set selectYearViewLeaveShow(String value) {
    _selectYearViewLeaveShow = value;
  }

  List<dynamic> _emptyJson = [];
  List<dynamic> get emptyJson => _emptyJson;
  set emptyJson(List<dynamic> value) {
    _emptyJson = value;
  }

  void addToEmptyJson(dynamic value) {
    emptyJson.add(value);
  }

  void removeFromEmptyJson(dynamic value) {
    emptyJson.remove(value);
  }

  void removeAtIndexFromEmptyJson(int index) {
    emptyJson.removeAt(index);
  }

  void updateEmptyJsonAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    emptyJson[index] = updateFn(_emptyJson[index]);
  }

  void insertAtIndexInEmptyJson(int index, dynamic value) {
    emptyJson.insert(index, value);
  }

  String _Uid = '';
  String get Uid => _Uid;
  set Uid(String value) {
    _Uid = value;
  }

  String _profileServiceDurationYY = '';
  String get profileServiceDurationYY => _profileServiceDurationYY;
  set profileServiceDurationYY(String value) {
    _profileServiceDurationYY = value;
  }

  String _profileServiceDurationMM = '';
  String get profileServiceDurationMM => _profileServiceDurationMM;
  set profileServiceDurationMM(String value) {
    _profileServiceDurationMM = value;
  }

  String _profileServiceDurationDD = '';
  String get profileServiceDurationDD => _profileServiceDurationDD;
  set profileServiceDurationDD(String value) {
    _profileServiceDurationDD = value;
  }

  String _profileBranchName = '';
  String get profileBranchName => _profileBranchName;
  set profileBranchName(String value) {
    _profileBranchName = value;
  }

  String _profileBranchCode = '';
  String get profileBranchCode => _profileBranchCode;
  set profileBranchCode(String value) {
    _profileBranchCode = value;
  }

  TrackingEmployeeDataModelStruct _EmpProfileLocationSelected =
      TrackingEmployeeDataModelStruct();
  TrackingEmployeeDataModelStruct get EmpProfileLocationSelected =>
      _EmpProfileLocationSelected;
  set EmpProfileLocationSelected(TrackingEmployeeDataModelStruct value) {
    _EmpProfileLocationSelected = value;
  }

  void updateEmpProfileLocationSelectedStruct(
      Function(TrackingEmployeeDataModelStruct) updateFn) {
    updateFn(_EmpProfileLocationSelected);
  }

  List<TrackingEmployeeDataModelStruct> _EmpProfileLocationData = [];
  List<TrackingEmployeeDataModelStruct> get EmpProfileLocationData =>
      _EmpProfileLocationData;
  set EmpProfileLocationData(List<TrackingEmployeeDataModelStruct> value) {
    _EmpProfileLocationData = value;
  }

  void addToEmpProfileLocationData(TrackingEmployeeDataModelStruct value) {
    EmpProfileLocationData.add(value);
  }

  void removeFromEmpProfileLocationData(TrackingEmployeeDataModelStruct value) {
    EmpProfileLocationData.remove(value);
  }

  void removeAtIndexFromEmpProfileLocationData(int index) {
    EmpProfileLocationData.removeAt(index);
  }

  void updateEmpProfileLocationDataAtIndex(
    int index,
    TrackingEmployeeDataModelStruct Function(TrackingEmployeeDataModelStruct)
        updateFn,
  ) {
    EmpProfileLocationData[index] = updateFn(_EmpProfileLocationData[index]);
  }

  void insertAtIndexInEmpProfileLocationData(
      int index, TrackingEmployeeDataModelStruct value) {
    EmpProfileLocationData.insert(index, value);
  }

  List<LatLng> _polyMapLatLngList = [];
  List<LatLng> get polyMapLatLngList => _polyMapLatLngList;
  set polyMapLatLngList(List<LatLng> value) {
    _polyMapLatLngList = value;
  }

  void addToPolyMapLatLngList(LatLng value) {
    polyMapLatLngList.add(value);
  }

  void removeFromPolyMapLatLngList(LatLng value) {
    polyMapLatLngList.remove(value);
  }

  void removeAtIndexFromPolyMapLatLngList(int index) {
    polyMapLatLngList.removeAt(index);
  }

  void updatePolyMapLatLngListAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    polyMapLatLngList[index] = updateFn(_polyMapLatLngList[index]);
  }

  void insertAtIndexInPolyMapLatLngList(int index, LatLng value) {
    polyMapLatLngList.insert(index, value);
  }

  List<String> _polyMapTimeList = [];
  List<String> get polyMapTimeList => _polyMapTimeList;
  set polyMapTimeList(List<String> value) {
    _polyMapTimeList = value;
  }

  void addToPolyMapTimeList(String value) {
    polyMapTimeList.add(value);
  }

  void removeFromPolyMapTimeList(String value) {
    polyMapTimeList.remove(value);
  }

  void removeAtIndexFromPolyMapTimeList(int index) {
    polyMapTimeList.removeAt(index);
  }

  void updatePolyMapTimeListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    polyMapTimeList[index] = updateFn(_polyMapTimeList[index]);
  }

  void insertAtIndexInPolyMapTimeList(int index, String value) {
    polyMapTimeList.insert(index, value);
  }

  bool _isProduction = false;
  bool get isProduction => _isProduction;
  set isProduction(bool value) {
    _isProduction = value;
  }

  bool _isInApp = false;
  bool get isInApp => _isInApp;
  set isInApp(bool value) {
    _isInApp = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
