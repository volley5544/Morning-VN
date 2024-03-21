import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';
import 'package:mobile_application_srisawad/widgets/fields/customCupertino.dart';

import '../../bloc/register_bloc/register_bloc.dart';

void ScrollDateField<String>(
  final DateTime initDate,
  final BuildContext context,
) {
  showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
            late DateTime selecteDate;
            DateTime dateTime = DateTime.now();
            DateTime currentDate = initDate;

            return BlocBuilder<RegisterBloc, RegisterState>(
                builder: (blocContext, state) {
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
                          'เลือกวันเดือนปีเกิด',
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
                            context.read<RegisterBloc>().add(GetDataFromField(
                                state.thaiId,
                                state.phoneNumber,
                                state.firstname,
                                state.lastname,
                                selecteDate.toString(),
                                state.address,
                                state.province,
                                state.district,
                                state.subdistrict,
                                state.poscode,
                                state.email,
                                state.lastname,
                                state.isValidated));
                            Navigator.pop(context);
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              fontFamily: 'NotoSansThai',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: HexColor('#646464')),
                        ),
                      ),
                      child: CustomCupertinoDatePicker(
                        itemExtent: 50,
                        minDate: DateTime(
                          dateTime.year + 477,
                          dateTime.month,
                          dateTime.day,
                        ),
                        maxDate: DateTime(
                          dateTime.year + 523,
                          dateTime.month,
                          dateTime.day,
                        ),
                        selectedDate: currentDate,
                        selectionOverlay: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: HexColor('#646464'),
                                width: 0.1,
                              ),
                            ),
                          ),
                        ),
                        selectedStyle: TextStyle(
                          color: HexColor('#DB771A'),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'NotoSansThai',
                        ),
                        unselectedStyle: TextStyle(
                            color: HexColor('#646464'),
                            fontSize: 18,
                            fontFamily: 'NotoSansThai'),
                        disabledStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                            fontFamily: 'NotoSansThai'),
                        onSelectedItemChanged: (date) => selecteDate = date,
                      ),
                    ),
                  ),
                ],
              );
            });
          }));
}
