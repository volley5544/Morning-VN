import 'dart:convert';

import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as lS;
import 'package:mobile_application_srisawad/models/penalty_model.dart';

var localStorageObject = lS.LocalStoragePrefernces();
String targetKey = 'pnt';

Future removePenaltyLocalStorage() async {
  await localStorageObject.removeLocalStorage(targetKey);
}

Future<PenaltyStorage> setPenalty(
    bool lockPin, int failedCounter, int timer, int nextPenaltyTime) async {
  final String value =
      '{"lock_pin" : $lockPin, "failed_counter" : $failedCounter, "timer" : $timer, "nextPenaltyTime": $nextPenaltyTime}';
  await localStorageObject.setLocalStorage(targetKey, value, 'string');
  final _ = PenaltyStorage.fromJson(jsonDecode(value));

  return _;
}

Future<PenaltyStorage> getPenalty() async {
  dynamic pnt = await localStorageObject.getLocalStorage(targetKey, 'string');
  if (pnt == null) {
    return PenaltyStorage.fromJson(jsonDecode('''{
      "lock_pin": false,
      "failed_counter": 1,
      "timer": 0,
      "nextPenaltyTime": 0}'''));
  } else {
    PenaltyStorage penaltyStorage = PenaltyStorage.fromJson(
      jsonDecode(pnt.toString()),
    );
    return penaltyStorage;
  }
}
