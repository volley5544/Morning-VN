import 'package:flutter/material.dart';

class BarCodeTabSelector extends StatefulWidget {
  final Function onQrCodeSelected;
  final bool isQrCodeSelected;
  const BarCodeTabSelector({
    Key? key,
    required this.onQrCodeSelected,
    required this.isQrCodeSelected,
  }) : super(key: key);

  @override
  State<BarCodeTabSelector> createState() => _BarCodeTabSelector();
}

class _BarCodeTabSelector extends State<BarCodeTabSelector> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator TabselectorWidget - INSTANCE
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        width: 326,
        height: 48,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Color.fromRGBO(239, 239, 239, 1),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
            onTap: () => widget.onQrCodeSelected(true),
            child: Container(
                width: 162,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color: widget.isQrCodeSelected
                      ? const Color.fromRGBO(0, 48, 99, 1)
                      : null,
                ),
                child: Center(
                    child: Text('คิวอาร์โค้ด',
                        style: TextStyle(
                            color: !widget.isQrCodeSelected
                                ? const Color.fromRGBO(0, 48, 99, 1)
                                : const Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'NotoSansThai',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1)))),
          ),
          GestureDetector(
            onTap: () => widget.onQrCodeSelected(false),
            child: Container(
                width: 162,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(24)),
                  color: !widget.isQrCodeSelected
                      ? const Color.fromRGBO(0, 48, 99, 1)
                      : null,
                ),
                child: Center(
                    child: Text(
                  'บาร์โค้ด',
                  style: TextStyle(
                      color: widget.isQrCodeSelected
                          ? const Color.fromRGBO(0, 48, 99, 1)
                          : const Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 14,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ))),
          ),
        ]),
      ),
    );
  }
}
