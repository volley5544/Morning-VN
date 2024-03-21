import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';

class PrivacyOther extends StatefulWidget {
  const PrivacyOther({Key? key}) : super(key: key);

  @override
  State<PrivacyOther> createState() => _PrivacyOtherState();
}

class _PrivacyOtherState extends State<PrivacyOther> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<PageResultBloc>(context)
                .add(SetButtonNavigator(true));
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/back-icon.svg'),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'นโยบายความเป็นส่วนตัว',
          style: Theme.of(context).textTheme.titleLarge!.merge(
              TextStyle(fontSize: 16, fontFamily: 'NotoSansThaiSemiBold')),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background-image.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    'ประกาศความเป็นส่วนตัว สำหรับบุคคลที่อาจเป็นลูกค้า ลูกค้าปัจจุบัน และบุคคลที่เกี่ยวข้อง',
                    style: Theme.of(context).textTheme.titleLarge!.merge(
                        TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 1.2,
                            fontFamily: 'NotoSansThaiSemiBold')),
                    textAlign: TextAlign.start,
                  ),
                ),
                FutureBuilder(
                    future: rootBundle.loadString("assets/privacypolicy.md"),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: Markdown(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            styleSheet: MarkdownStyleSheet.fromTheme(
                              ThemeData(
                                  textTheme: TextTheme(
                                      bodyText2: GoogleFonts.notoSansThai(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor('#003063')))),
                            ),
                            data: snapshot.data.toString(),
                          ),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(219, 119, 26, 1),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
