import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/connector/firestore/notify.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/notify_model.dart';
import 'package:mobile_application_srisawad/widgets/dialog/force_logout_dialog.dart';
import 'package:mobile_application_srisawad/widgets/flash/notify_top_flash.dart';
import 'package:mobile_application_srisawad/widgets/main_bottom_navigation_v2.dart';

import '../util/logger_service.dart';

void createNotificationReciever(String hashThaiId) {
  if (MessagingListenerList.isEmpty) {
    logger.i('Create Firebase messaging listener.');
    final notiListener =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      logger.i("test-noti:" + message.toString());
      if (message.data['event'] == 'notification') {
        NotifyModel value = NotifyModel.fromJson(
            {'sentTime': '01/01/0001', ...message.data, 'sendTimestamp': 0});
        final notiClient = NotifyConnector(hashThaiId);
        notiClient.setFlagNotify(selectedIndex != 2);
        showNotifyTopFlash(
            title: value.title,
            body: value.body,
            context: navKey.currentState!.context);
      } else if (message.data['event'] == 'active-device') {
        showForceLogOutDialog(navKey.currentState!.context);
      }
    });
    MessagingListenerList.add(notiListener);
  }
}

void createOnTokenRefreshListener(String hashThaiId) {
  if (MessagingOnRefreshTokenListenerList.isEmpty) {
    final notiClient = NotifyConnector(hashThaiId);
    final _listener =
        FirebaseMessaging.instance.onTokenRefresh.listen(((String token) {
      notiClient.setFcmToken(token);
    }));

    MessagingOnRefreshTokenListenerList.add(_listener);
  }
}
