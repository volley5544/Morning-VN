import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_srisawad/modules/vision/index.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/ocr_vision.dart';
import '../util/permission_handler_util.dart';
import 'dialog/ocr_not_found_dialog.dart';
import 'dialog/open_app_setting_dialog.dart';

class ImageToThaiid extends StatefulWidget {
  final TextEditingController textController;

  const ImageToThaiid({super.key, required this.textController});

  @override
  State<ImageToThaiid> createState() => _ImageToThaiid();
}

class _ImageToThaiid extends State<ImageToThaiid> {
  File? _storedImage;
  final visionClient = Vision();
  // bool _load = false;
  _takePicture(BuildContext context) async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
      OcrThaiId result = await visionClient.getThaiId(imageFile.path);

      bool emptyResult = result.thaiId.isEmpty;
      if (emptyResult) {
        Navigator.of(context).restorablePush(ocrNotFoundDialog(context));
        // Thai-id not found,Do alert here.
      } else {
        String newText = result.thaiId;
        widget.textController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
        ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: IconButton(
          onPressed: () {
            PermissionHandlerUtil.requestPermission(
                context: context,
                permission: Permission.camera,
                onGranted: () async {
                  _takePicture(context);
                });
          },
          icon: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.grey,
          ),
        )),
      ],
    );
  }
}
