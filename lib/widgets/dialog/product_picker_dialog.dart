import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../util/color_util.dart';
import '../text_compent.dart';

void showPickerDialog(
    {required BuildContext context,
    required String title,
    required List<String> dataList,
    required Function(int) onSelectedListener,
    int? initialIndex,
    String? textCancel,
    String? textSubmit}) {
  int selectedItem = initialIndex ?? 0;
  FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: selectedItem);
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 6, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14, right: 8, bottom: 4, top: 4),
                        child: TextButton(
                            onPressed: () {
                              controller.dispose();
                              Navigator.of(context).pop();
                            },
                            child: TextTitle(textCancel ?? "ยกเลิก")
                                .stylePrimary()),
                      ),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: TextTitle(title).styleSecondary(),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 14, bottom: 4, top: 4),
                        child: TextButton(
                            onPressed: () {
                              onSelectedListener(selectedItem);
                              controller.dispose();
                              Navigator.of(context).pop();
                            },
                            child: TextTitle(
                              textSubmit ?? "เลือก",
                            ).stylePrimary()),
                      ),
                    ],
                  ),
                  Divider(color: HexColor(ColorUtil.BORDER), height: 1),
                  Container(
                    height: 216,
                    child: StatefulBuilder(
                      builder: (context, setState) => CupertinoPicker(
                          scrollController: controller,
                          itemExtent: 60,
                          diameterRatio: 180,
                          selectionOverlay: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: HexColor("E5E5E5"), width: 1),
                                    bottom: BorderSide(
                                        color: HexColor("E5E5E5"), width: 1))),
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedItem = index;
                            });
                          },
                          children: List.generate(dataList.length, (index) {
                            final item = dataList[index];
                            final isSelected = selectedItem == index;
                            final textColor = isSelected
                                ? HexColor(ColorUtil.PRIMARY)
                                : HexColor(ColorUtil.GREY);
                            return Center(
                              child: Text(
                                item,
                                style: GoogleFonts.notoSansThai(
                                  letterSpacing: 0,
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  )
                ]),
              ),
            ),
          ));
}
