import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      _pinCode = prefs.getString('ff_pinCode') ?? _pinCode;
    });
    _safeInit(() {
      _username = prefs.getString('ff_username') ?? _username;
    });
    _safeInit(() {
      _employeeID = prefs.getString('ff_employeeID') ?? _employeeID;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

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

  List<String> _defaultList = ['Hello World', 'Hello World', 'Hello World'];
  List<String> get defaultList => _defaultList;
  set defaultList(List<String> value) {
    _defaultList = value;
  }

  void addToDefaultList(String value) {
    _defaultList.add(value);
  }

  void removeFromDefaultList(String value) {
    _defaultList.remove(value);
  }

  void removeAtIndexFromDefaultList(int index) {
    _defaultList.removeAt(index);
  }

  void updateDefaultListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _defaultList[index] = updateFn(_defaultList[index]);
  }

  void insertAtIndexInDefaultList(int index, String value) {
    _defaultList.insert(index, value);
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
    _defaultList2.add(value);
  }

  void removeFromDefaultList2(String value) {
    _defaultList2.remove(value);
  }

  void removeAtIndexFromDefaultList2(int index) {
    _defaultList2.removeAt(index);
  }

  void updateDefaultList2AtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _defaultList2[index] = updateFn(_defaultList2[index]);
  }

  void insertAtIndexInDefaultList2(int index, String value) {
    _defaultList2.insert(index, value);
  }

  String _employeeID = '';
  String get employeeID => _employeeID;
  set employeeID(String value) {
    _employeeID = value;
    prefs.setString('ff_employeeID', value);
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
