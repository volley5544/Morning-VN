import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/logger_service.dart';

// [thanasak] fix the flodername floder name should be snake case
class ProvinceDropDown extends StatefulWidget {
  const ProvinceDropDown({Key? key}) : super(key: key);

  @override
  State<ProvinceDropDown> createState() => _ProvinceDropDownState();
}

class _ProvinceDropDownState extends State<ProvinceDropDown> {
  int _selectedArea = 0;
  double _kItemExtent = 32.0;
  List<String> _areaName = <String>[
    'A',
    'B',
    'C',
    'D',
    'F',
    'E',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownFuction();
  }

  Widget DropdownFuction() {
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
    }

    return CupertinoButton(
        onPressed: () => _showDialog(
              CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: _kItemExtent,
                onSelectedItemChanged: (int selectedItem) {
                  setState(() {
                    logger.i('Select' '{$_selectedArea}' '{$selectedItem');
                    _selectedArea = selectedItem;
                  });
                },
                children: List<Widget>.generate(_areaName.length, (int index) {
                  logger.i('${_areaName[index]}');
                  return Center(
                    child: Text(_areaName[index]),
                  );
                }),
              ),
            ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: BoxDecoration(
              // border: Border.fromBorderSide()
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _areaName[_selectedArea],
                style: GoogleFonts.notoSansThai(color: Colors.black),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )
            ],
          ),
        ));
  }
}
