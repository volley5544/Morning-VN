import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as lS;
import 'package:mobile_application_srisawad/models/notify_model.dart';

var localStorageObject = lS.LocalStoragePrefernces();

String targetKey = 'notify';

Future removeNotifyLocalStorage() async {
  await localStorageObject.removeLocalStorage(targetKey);
}

Future clearNotifyLocalStorage() async {
  await localStorageObject.setLocalStorage(targetKey, '[]', 'string');
}

Future<List<NotifyModel>> setNotify(NotifyModel noti) async {
  List<NotifyModel> localNotify = await getNotify();
  final tes = [...localNotify, noti];
  String SaveValue = convert.jsonEncode(tes);
  await localStorageObject.setLocalStorage(targetKey, SaveValue, 'string');
  return tes;
}

Future<List<NotifyModel>> getNotify() async {
  dynamic notitifyList =
      await localStorageObject.getLocalStorage(targetKey, 'string');

  if (notitifyList == null) {
    return [];
  } else {
    List<dynamic> raw = convert.jsonDecode(notitifyList);
    List<NotifyModel> result = raw.map((e) => NotifyModel.fromJson(e)).toList();
    return result;
  }
}
