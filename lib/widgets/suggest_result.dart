import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/pages/map/map_controller/map_controller.dart';

class SuggetResult extends StatelessWidget {
  final String squery;
  final BranchDetail branchDetail;
  final Function setSelectedSuggestion;
  final Position position;
  const SuggetResult(this.squery, this.branchDetail, this.setSelectedSuggestion,
      this.position);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setSelectedSuggestion([branchDetail]),
      child: Container(
        width: 500,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: []),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(28, 10, 19, 8),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 260,
                      child: Text.rich(
                        TextSpan(
                          // with no TextStyle it will have default text style

                          style: TextStyle(color: HexColor('#003063')),
                          children: <TextSpan>[
                            TextSpan(
                                text: branchDetail.branchName,
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 48, 99, 1),
                                    fontFamily: 'NotoSansThai',
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w400,
                                    height: 1)),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/DistanceIcon.svg'),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                              getBranchDistance(branchDetail, position) +
                                  ' กม.',
                              // '${branchDetail.distance?.toStringAsFixed(1)} กม.',
                              style: TextStyle(
                                  color: HexColor(
                                    '#8B99A7',
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                      '${branchDetail.brnachAddress} ${branchDetail.subDistrict} ${branchDetail.district} ${branchDetail.province}',
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.start,
                      style: TextStyle(
                          color: HexColor('#8B99A7'),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),

                // )
              ]),
            ),
            Container(
              height: 1,
              color: Color.fromRGBO(230, 230, 230, 1), // F)0000
            )
          ],
        ),
      ),
    );
    // );
  }
}
