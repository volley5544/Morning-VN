import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/util/permission_handler_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart'
    as getUserProfile;

import '../../../util/logger_service.dart';
import '../../../widgets/image_selector.dart';

class DisplayImage extends StatefulWidget {
  final String thaiId;
  final Uint8List imageFile;
  final Function uploadCallback;
  final BuildContext userProfileContext;

  const DisplayImage({
    super.key,
    required this.thaiId,
    required this.imageFile,
    required this.uploadCallback,
    required this.userProfileContext,
  });

  @override
  State<DisplayImage> createState() => _DisplayImage();
}

class _DisplayImage extends State<DisplayImage> {
  // getUserProfile.UserProfile userProfile = getUserProfile.UserProfile();

  // late String currentPath = 'assets/Search.png';
  late File _photo;
  final ImagePicker _picker = ImagePicker();
  getUserProfile.UserProfile userProfile = getUserProfile.UserProfile();

// Uint8List bytes = imageData.buffer.asUint8List();
  StorageConnector storageConnector = StorageConnector();

  Future imgFromGallery(context) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        widget.uploadCallback(_photo);
      } else {
        logger.i('No image selected.');
      }
    });
  }

  Future imgFromCamera(context) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 30);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        widget.uploadCallback(_photo);
      } else {
        logger.i('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return ImageSelector(
            imgFromCamera: (String) async {
              Navigator.pop(context);
              PermissionHandlerUtil.requestPermission(
                  context: context,
                  permission: Permission.camera,
                  onGranted: () async {
                    await imgFromCamera(context);
                  });
            },
            imgFromGallery: (String) async {
              Navigator.pop(context);
              Permission permission;
              if (Platform.isAndroid) {
                final androidInfo = await DeviceInfoPlugin().androidInfo;
                if (androidInfo.version.sdkInt <= 32) {
                  permission = Permission.storage;
                } else {
                  permission = await Permission.photos;
                }
              } else {
                permission = await Permission.photos;
              }
              PermissionHandlerUtil.requestPermission(
                  context: context,
                  permission: permission,
                  onGranted: () async {
                    await imgFromGallery(context);
                  });
            },
          );

          // SafeArea(
          //   child: Wrap(
          //     children: <Widget>[
          //       Container(
          //         padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          //         decoration: BoxDecoration(
          //           border: Border(
          //             bottom: BorderSide(color: HexColor('#E5E5E5')),
          //           ),
          //         ),
          //         child: ListTile(
          //             leading: SvgPicture.asset(
          //               'assets/GallaryIcon.svg',
          //               height: 32,
          //               width: 32,
          //             ),
          //             title: const Text('เลือกจากคลังภาพ'),
          //             onTap: () {
          //               imgFromGallery(context);
          //               Navigator.of(context).pop();
          //             }),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(10),
          //         child: ListTile(
          //           leading: SvgPicture.asset(
          //             'assets/CamearIcon.svg',
          //             height: 32,
          //             width: 32,
          //           ),
          //           title: const Text('ถ่ายภาพ'),
          //           onTap: () {
          //             imgFromCamera(context);
          //             Navigator.of(context).pop(context);
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            height: 114,
            width: 114,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(232, 144, 62, 1),
                width: 1,
              ),
              image: DecorationImage(
                  image: AssetImage('assets/user-default.png'),
                  fit: BoxFit.fitWidth),
              borderRadius: const BorderRadius.all(Radius.circular(114 / 2)),
            ),
            child: ClipRRect(
              child: Image.memory(
                Uint8List.fromList(widget.imageFile),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(114 / 2),
            )),
        Positioned(
            bottom: -10,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(context).primaryColor,
                child: SvgPicture.asset('assets/camera-icon.svg',
                    width: 28, fit: BoxFit.contain),
              ),
            )),
      ],
    );
  }
}
