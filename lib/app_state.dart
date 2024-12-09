import 'package:flutter/material.dart';
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

  String _apiUrlAppState =
      'https://39fe-115-31-145-24.ngrok-free.app/ssw_morning_fm';
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

  String _profileStartDate = '[startdate]';
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

  String _profileServiceDuration = '1 ปี 6 เดือน 6 วัน';
  String get profileServiceDuration => _profileServiceDuration;
  set profileServiceDuration(String value) {
    _profileServiceDuration = value;
  }

  String _profilePosisionAge = '1 ปี 6 เดือน 6 วัน';
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

  List<String> _leaveHalfDay = [
    'ลาเต็มวัน',
    'ลาครึ่งวันเช้า',
    'ลาครึ่งวันบ่าย'
  ];
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

  List<String> _leaveFullDay = ['ลาเต็มวัน'];
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
