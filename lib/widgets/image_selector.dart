import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageSelector extends StatelessWidget {
  // final Future<void> Function(String) onPressed;

  final Future<void> Function(String)? imgFromGallery;
  final Future<void> Function(String) imgFromCamera;
  const ImageSelector({
    super.key,
    required this.imgFromCamera,
    this.imgFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          imgFromGallery == null
              ? Container()
              : Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: HexColor('#E5E5E5')),
                    ),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/GallaryIcon.svg',
                      height: 32,
                      width: 32,
                    ),
                    title: const Text('เลือกจากคลังภาพ'),
                    onTap: () async => await imgFromGallery!(''),
                    // onTap: () async => await this.imgFromGallery,
                  ),
                ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/CamearIcon.svg',
                height: 32,
                width: 32,
              ),
              title: const Text('ถ่ายภาพ'),
              onTap: () async => await imgFromCamera(''),
            ),
          ),
        ],
      ),
    );
  }
}
