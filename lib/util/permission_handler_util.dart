import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobile_application_srisawad/widgets/dialog/open_app_setting_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerUtil {
  PermissionHandlerUtil._();

  static const String cameraPermanentlyDeniedTitle =
      "อนุญาตให้เข้าถึงกล้องของอุปกรณ์ ของคุณ";
  static const String cameraPermanentlyDeniedDetail =
      "เพื่ออนุญาตให้คุณบันทึกหรืออัปโหลดรูปภาพได้ คุณต้องไปที่การตั้งค่าและกดเปิดที่กล้องของคุณ";
  static const String photoPermanentlyDeniedTitle =
      "อนุญาตให้เข้าถึงรูปภาพของคุณ";
  static const String photoPermanentlyDeniedDetail =
      "เพื่ออนุญาตให้คุณบันทึกหรืออัปโหลดรูปภาพได้ คุณต้องไปที่การตั้งค่าและไปที่รูปภาพและ ทำการกดอนุญาตการเข้าถึงรูปภาพของคุณ";

  static requestPermission(
      {required BuildContext context,
      required Permission permission,
      Function? onDenied,
      Function? onGranted,
      Function? onPermanentlyDenied}) {
    if (Platform.isAndroid) {
      _handleRequestPermissionOnAndroid(
          context: context,
          permission: permission,
          onDenied: onDenied,
          onGranted: onGranted,
          onPermanentlyDenied: onPermanentlyDenied);
    } else {
      _handleRequestPermissionOnIOS(
          context: context,
          permission: permission,
          onDenied: onDenied,
          onGranted: onGranted,
          onPermanentlyDenied: onPermanentlyDenied);
    }
  }

  /// Please check your permission is enabled in AndroidManifest
  static _handleRequestPermissionOnAndroid(
      {required BuildContext context,
      required Permission permission,
      Function? onDenied,
      Function? onGranted,
      Function? onPermanentlyDenied}) async {
    final permissionStatus = await permission.status;
    if (permissionStatus.isDenied ||
        permissionStatus.isPermanentlyDenied ||
        permissionStatus.isLimited) {
      onDenied?.call();
      final requestPermissionResult = await permission.request();
      if (requestPermissionResult.isGranted || permissionStatus.isLimited) {
        onGranted?.call();
      } else if (requestPermissionResult.isPermanentlyDenied) {
        onPermanentlyDenied?.call() ??
            _defaultOnPermanentlyDenied(context, permission);
      }
    } else if (permissionStatus.isGranted) {
      onGranted?.call();
    }
  }

  /// Please check your permission is enabled in podfile
  static _handleRequestPermissionOnIOS(
      {required BuildContext context,
      required Permission permission,
      Function? onDenied,
      Function? onGranted,
      Function? onPermanentlyDenied}) async {
    final permissionStatus = await permission.status;
    if (permissionStatus.isLimited) {
      onGranted?.call();
      return;
    } else if (permissionStatus.isDenied) {
      onDenied?.call();
      final requestPermissionResult = await permission.request();
      if (requestPermissionResult.isGranted) {
        onGranted?.call();
      }
    } else if (permissionStatus.isGranted) {
      onGranted?.call();
    } else if (permissionStatus.isPermanentlyDenied) {
      onPermanentlyDenied?.call() ??
          _defaultOnPermanentlyDenied(context, permission);
    }
  }

  static _defaultOnPermanentlyDenied(
      BuildContext context, Permission permission) {
    String title = "Please specific title";
    String detail = "Please specific message";
    if (permission == Permission.camera) {
      title = cameraPermanentlyDeniedTitle;
      detail = cameraPermanentlyDeniedDetail;
    } else if (permission == Permission.photos ||
        permission == Permission.storage) {
      title = photoPermanentlyDeniedTitle;
      detail = photoPermanentlyDeniedDetail;
    }
    openAppSettingDialog(context: context, title: title, detail: detail);
  }
}
