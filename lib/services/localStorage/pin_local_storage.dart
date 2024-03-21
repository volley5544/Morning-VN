import 'dart:convert' as convert;
import 'dart:convert';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as lS;
import 'package:mobile_application_srisawad/models/pin_model.dart';

final localStorageObject = lS.LocalStoragePrefernces();
String targetKey = 'pin';
String targetBackupKey = 'backup_pin';

Future<bool> isVaildPin() async {
  PinStorage pinObject = await getPin();
  if (pinObject.pin != 'null') {
    return true;
  }
  return false;
}

Future removePinLocalStorage() async {
  await localStorageObject.removeLocalStorage(targetKey);
}

Future setBackupPin(PinStorage pinObj) async {
  final result = await getAllBackupPin();
  final res = {};
  for (MapEntry<String, dynamic> item in result.entries) {
    res[item.key] = {
      'hash_thai_id': item.value.hashThaiId,
      'phone_number': item.value.phoneNumber,
      'pin': item.value.pin,
      'ct_timestamp': item.value.ctTimestamp,
      'up_timestamp': item.value.upTimestamp
    };
  }
  final _ = jsonEncode({
    ...res,
    '${pinObj.hashThaiId}': {
      "hash_thai_id": "${pinObj.hashThaiId}",
      "phone_number": "${pinObj.phoneNumber}",
      "pin": "${pinObj.pin}",
      "ct_timestamp": "${DateTime.now().toString()}",
      "up_timestamp": "${DateTime.now().toString()}"
    }
  });

  localStorageObject.setLocalStorage(targetBackupKey, _, 'string');
}

Future<Map<String, PinStorage>> getAllBackupPin() async {
  dynamic backupPin =
      await localStorageObject.getLocalStorage(targetBackupKey, 'string');
  if (backupPin == null) {
    return {};
  } else {
    final Map<String, PinStorage> _output = {};
    final Map<String, dynamic> _ = json.decode(backupPin);
    for (MapEntry<String, dynamic> item in _.entries) {
      _output[item.key] = PinStorage(
          hashThaiId: item.value['hash_thai_id'],
          phoneNumber: item.value['phone_number'],
          pin: item.value['pin'],
          ctTimestamp: item.value['ct_timestamp'],
          upTimestamp: item.value['up_timestamp']);
    }
    return _output;
  }
}

Future<PinStorage> getBackupPin(String hashThaiId) async {
  dynamic backupPin =
      await localStorageObject.getLocalStorage(targetBackupKey, 'string');
  if (backupPin == null) {
    return PinStorage.fromJson(convert.jsonDecode('''{
      "hash_thai_id": "null",
      "phone_number": "null",
      "pin": "null",
      "ct_timestamp": "null",
      "up_timestamp": "null"
    }'''));
  } else {
    final Map<String, dynamic> _ = json.decode(backupPin);
    final _tmp = _['${hashThaiId}'];
    if (_tmp == null) {
      return PinStorage.fromJson(convert.jsonDecode('''{
      "hash_thai_id": "null",
      "phone_number": "null",
      "pin": "null",
      "ct_timestamp": "null",
      "up_timestamp": "null"
    }'''));
    } else {
      return PinStorage(
          hashThaiId: _tmp['hash_thai_id'],
          phoneNumber: _tmp['phone_number'],
          pin: _tmp['pin'],
          ctTimestamp: _tmp['ct_timestamp'],
          upTimestamp: _tmp['up_timestamp']);
    }
  }
}

Future<PinStorage> setPin(
    String inputText, String thaiId, String phoneNumber) async {
  final String value =
      '{"hash_thai_id" : "$thaiId", "phone_number" : "$phoneNumber", "pin" : "${inputText}", "ct_timestamp" : "${DateTime.now().toString()}",  "up_timestamp" :"${DateTime.now().toString()}"}';

  await localStorageObject.setLocalStorage(targetKey, value, 'string');
  final _ = PinStorage.fromJson(jsonDecode(value));

  return _;
}

Future<PinStorage> getPin() async {
  dynamic pin = await localStorageObject.getLocalStorage(targetKey, 'string');
  if (pin == null) {
    return PinStorage.fromJson(convert.jsonDecode('''{
      "hash_thai_id": "null",
      "phone_number": "null",
      "pin": "null",
      "ct_timestamp": "null",
      "up_timestamp": "null"
    }'''));
  } else {
    PinStorage pinStorage = PinStorage.fromJson(
      convert.jsonDecode(pin.toString()),
    );
    return pinStorage;
  }
}
