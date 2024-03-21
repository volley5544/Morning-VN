import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/pages/registercompent/province_dropdown.dart';
import 'package:mobile_application_srisawad/pages/user_process/privacy.dart';
import 'package:mobile_application_srisawad/pages/user_register/recheck_register.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class RegisterSrceen extends StatefulWidget {
  const RegisterSrceen({Key? key}) : super(key: key);

  @override
  State<RegisterSrceen> createState() => _RegisterSrceenState();
}

class _RegisterSrceenState extends State<RegisterSrceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สมัครสมาชิก',
          style: GoogleFonts.notoSansThai(color: HexColor('#DB771A')),
          textAlign: TextAlign.start,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.orange,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'หมายเลขบัตรประชาชน',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: '1-1234-56789-12-3',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'เบอร์โทรศัพท์',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: '098-231-1322',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'กรุณากรอกข้อมูลเพิ่มเติม',
                style: GoogleFonts.notoSansThai(
                  fontSize: 18,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const VerticalDivider(
                      width: 20,
                      thickness: 3,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'ข้อมูลพื้นฐาน',
                    style: GoogleFonts.notoSansThai(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'ชื่อ',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: 'ระบุชื่อ(ภาษาไทย)',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'นามสกุล',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: 'ระบุนามสกุล(ภาษาไทย)',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'XX/XX/XXXX',
                  label: Text(
                    'วัน เดือน ปีเกิด(พ.ศ.)',
                    style: GoogleFonts.notoSansThai(),
                  ),
                ),
                // inputFormatters: [DateInputFormatter()],
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.datetime,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const VerticalDivider(
                      width: 20,
                      thickness: 3,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'ข้อมูลที่อยู่',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.notoSansThai(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'ระบุรายละเอียดที่อยู่',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: 'ระบุรายละเอียดที่อยู่',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              ProvinceDropDown(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: const VerticalDivider(
                      width: 20,
                      thickness: 3,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'ข้อมูลติดต่ออื่นๆ',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.notoSansThai(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    'อีเมล',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: 'ระบุอีเมล(ไม่บังคับ)',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z._-]')),
                ],
                decoration: InputDecoration(
                  label: Text(
                    'ไลน์ไอดี(Line ID)',
                    style: GoogleFonts.notoSansThai(color: Colors.black),
                  ),
                  hintText: 'ระบุไลน​์ไอดี(ไม่บังคับ)',
                  hintStyle: GoogleFonts.notoSansThai(),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(15)),
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/user-detail');
          },
          child: Text(
            'สมัครสมาชิก',
            style: GoogleFonts.notoSansThai(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
