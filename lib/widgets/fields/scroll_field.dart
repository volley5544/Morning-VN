import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

void ScrollField(
  final String title,
  final List<dynamic> choice,
  final TextEditingController controller,
  final Function onClose,
  final Function onSelected,
  final Function onDismissible,
  final int currentIndex,
  final BuildContext context,
) {
  int indexFromField = choice.indexWhere(((book) => book == controller.text));
  int indexSelect = indexFromField;

  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
            FixedExtentScrollController scroll =
                FixedExtentScrollController(initialItem: indexFromField);
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(
                          'ยกเลิก',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: HexColor('#DB771A')),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      CupertinoButton(
                        child: Text(
                          'เลือก',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: HexColor('#DB771A')),
                        ),
                        onPressed: () {
                          onSelected(indexSelect, currentIndex);
                          Navigator.pop(context, indexSelect);
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  color: Colors.white,
                  child: CupertinoPicker(
                    selectionOverlay: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0,
                              color: HexColor('#8B99A7').withOpacity(0.25)),
                          bottom: BorderSide(
                              width: 1.0,
                              color: HexColor('#8B99A7').withOpacity(0.25)),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                    magnification: 1.22,
                    squeeze: 0.7,
                    itemExtent: 40,
                    scrollController: scroll,
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        indexSelect = selectedItem;
                      });
                    },
                    children: List<Widget>.generate(choice.length, (int index) {
                      bool isSelected = indexSelect == index;

                      // final item =
                      //     address == 3 ? subdistrictList[index].name : list[index];
                      final color = isSelected
                          ? HexColor('#DB771A')
                          : HexColor('#646464');
                      return Center(
                        child: Text(
                          choice[index],
                          style: GoogleFonts.notoSansThai(
                            fontSize: 16,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }));
}
