import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MapLoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const MapLoadingOverlay({Key? key, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.black.withOpacity(0.6),
            child: Center(
                child: Container(
              width: 129,
              height: 141,
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Container(
                      child: Image.asset(
                        'assets/srisawad-loading.gif',
                        height: 84,
                        width: 84,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text('กำลังโหลด...')),
                ],
              ),
            )),
          )
        : Container();
  }
}
