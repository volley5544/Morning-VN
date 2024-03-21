import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class DetailCard {
  DetailCard(
    this.title,
    this.body, [
    this.isExpanded = false,
  ]);

  String title;
  String body;
  bool isExpanded;
}

List<DetailCard> getDetailCards() {
  return [
    DetailCard('ศรีสวัสดิ์ เงินสดทันใจ ให้บริการอะไรบ้าง?',
        '• ให้บริการจัดหาสินเชื่อทะเบียนรถมอเตอร์ไซค์ , สินเชื่อทะเบียนรถยนต์ , สินเชื่อทะเบียนรถบรรทุก , สินเชื่อทะเบียนรถเพื่อการเกษตร และสินเชื่อบ้าน/ที่ดิน\n• ให้บริการด้านประกันภัยรถยนต์ ประกันอุบัติเหตุส่วนบุคคล (PA) และ พ.ร.บ.\n• ให้บริการรับฝากเงิน ชำระบิล และการยืนยันตัวตนเพื่อเปิดบัญชีธนาคาร'),
    DetailCard('เวลาที่เปิดให้บริการ',
        'วันจันทร์ ถึง วันศุกร์ เวลา 08.30 – 16.30 น. \nวันเสาร์ เวลา 08.30 – 15.30 น.'),
    DetailCard('ช่องทางติดต่อ ศรีสวัสดิ์ เงินสดทันใจ',
        '1.ติดต่อด้วยตนเอง ที่ศรีสวัสดิ์ เงินสดทันใจ ทุกสาขาทั่วประเทศ\n2.ศูนย์ลูกค้าสัมพันธ์ โทร. 1652\n3.อีเมล : callcenter.sawad@srisawadpower.com\n4.เว็บไซต์ www.sawad.co.th\n5.Facebook : https://www.facebook.com/srisawadpower \n6.LINE@ : @srisawad'),
    DetailCard('สินเชื่อ ศรีสวัสดิ์ เงินสดทันใจ ดีกว่าที่อื่นอย่างไร',
        '• วงเงินสูง อนุมัติไว ได้เงินเร็ว\n• รับรีไฟแนนซ์รถมอเตอร์ไซค์และรถยนต์ ผ่อนอยู่ก็กู้ได้\n• ไม่ต้องโอนเล่ม / ไม่ต้องจดจำนอง\n• ไม่ต้องใช้คนค้ำประกัน\n• ไม่เช็คประวัติการเงิน\n• ไม่ต้องใช้สลิปเงินเดือน\nสาขาพร้อมให้บริการกว่า 5,000 สาขาทั่วประเทศ อยู่ที่ไหนก็จัดสินเชื่อได้\n*เงื่อนไขการจัดสินเชื่อเบื้องต้นเป็นไปตามที่บริษัทฯกำหนด'),
    DetailCard('คุณสมบัติ และเอกสารเบื้องต้น',
        'หลักเกณฑ์และเงื่อนไขการพิจารณาอนุมัติสินเชื่อมีเงื่อนไขที่แตกต่างกันเป็นไปตามที่บริษัทฯกำหนด โดยขึ้นอยู่กับคุณสมบัติและสินทรัพย์ของผู้กู้ ทั้งวงเงินสินเชื่อ ดอกเบี้ย และค่างวดผ่อนชำระ เป็นต้น สินเชื่อแต่ละประเภทมีเงื่อนไขแตกต่างกันค่ะ สอบถามรายละเอียดสินเชื่อ โทร. 1652\nคุณสมบัติผู้สมัครผู้กู้\n• สัญชาติไทย\n• อายุ 20-65 ปี\n• มีชื่อเป็นเจ้าของเล่มทะเบียนรถ หรือเจ้าของโฉนดที่ดิน\nเอกสารเบื้องต้นที่ใช้ในการพิจารณาสินเชื่อ ได้แก่\n1.บัตรประชาชน\n2.ทะเบียนบ้าน\n3.เล่มทะเบียนรถตัวจริง/โฉนดที่ดินตัวจริง\n4.เอกสารแสดงรายได้ เช่น สลิปเงินเดือน/หนังสือรับรองเงินเดือน/สมุดบัญชีธนาคารย้อน (ถ้ามี)\n5.สมุดบัญชีธนาคาร เพื่อรับเงินโอน\nเอกสารเพิ่มเติม ในกรณีรีไฟแนนซ์\n• เอกสารแสดงรายได้ (ถ้ามี)\n• สำเนาเล่มทะเบียนรถ\n• เอกสารสัญญาไฟแนนซ์ปัจจุบัน หรือ การ์ดค่างวด\n• เอกสารบิลใบเสร็จย้อนหลัง 1 งวด (ล่าสุด)'),
    DetailCard('ติดแบล็กลิสต์สามารถใช้บริการสินเชื่อที่ศรีสวัสดิ์ได้หรือไม่?',
        'สามารถใช้บริการได้ทุกสินเชื่อ ศรีสวัสดิ์ เงินสดทันใจ ไม่เช็คประวัติการเงินค่ะ'),
    DetailCard('รับรถปีไหนบ้าง?',
        'รถยนต์ไม่เกิน 20 ปี และรถจักรยานยนต์ไม่เกิน 7 ปี\n*เงื่อนไขการจัดสินเชื่อเบื้องต้นเป็นไปตามที่บริษัทฯกำหนด'),
    DetailCard('คิดดอกเบี้ยอย่างไร?',
        'หลักเกณฑ์และเงื่อนไขการพิจารณาอนุมัติสินเชื่อมีเงื่อนไขที่แตกต่างกันเป็นไปตามที่บริษัทกำหนด โดยขึ้นอยู่กับคุณสมบัติและสินทรัพย์ของผู้กู้ ทั้งวงเงินสินเชื่อ ดอกเบี้ย และค่างวดผ่อนชำระ เป็นต้น สินเชื่อแต่ละประเภทมีเงื่อนไขแตกต่างกันค่ะ สอบถามรายละเอียดสินเชื่อ โทร. 1652'),
    DetailCard('ศรีสวัสดิ์ เงินสดทันใจ ขายประกันรถของบริษัทอะไรบ้าง?',
        '• บริษัท อลิอันซ์ อยุธยา ประกันภัย จำกัด (มหาชน)\n• บริษัท ชับบ์สามัคคีประกันภัย จำกัด (มหาชน)\n• บริษัท ทิพยประกันภัย จำกัด (มหาชน)\n• บริษัท ฟอลคอนประกันภัย จำกัด (มหาชน)\n• บริษัท แอลเอ็มจี ประกันภัย จำกัด (มหาชน)\n• บริษัท สินมั่นคง ประกันภัย จำกัด (มหาชน)\n• บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย) จำกัด (มหาชน)\n• บริษัท วิริยะประกันภัย จำกัด (มหาชน)\n• บริษัท เมืองไทย ประกันภัย จำกัด (มหาชน)\n• บริษัท กรุงเทพประกันภัย จำกัด (มหาชน)\n• บริษัท ไทยวิวัฒน์ ประกันภัย จำกัด (มหาชน)\n• นายหน้าประกันวินาศภัย: บริษัท ศรีสวัสดิ์ พาวเวอร์ 2014 เลขที่ใบอนุญาต ว 00011/2561'),
    DetailCard('ซื้อประกันรถ กับศรีสวัสดิ์ เงินสดทันใจ ดีกว่าอย่างไร',
        '• ผ่อนเงินสดได้ 0% ไม่ต้องใช้บัตรเครดิต นานสูงสุดติดกันถึง 12 งวด\n• มั่นใจ ให้ความคุ้มครองทันทีหลังทำประกันรถยนต์\n• ประกันมีให้เลือกครบทุกประเภท ตามความต้องการ ไม่ว่าจะเป็นประชั้น 1 , 2+, 3+ , 3\n• สาขาพร้อมให้บริการ กว่า 5,000 สาขาทั่วไทย'),
    DetailCard('ต่อ พ.ร.บ. รถทุกประเภทมีครบ รับได้ทันทีไหม',
        'ซื้อ พ.ร.บ. ที่ศรีสวัสดิ์ ราคาจริงใจ รอรับได้ทันที ที่สาขาศรีสวัสดิ์ เงินสดทันใจ ทั่วประเทศกว่า 5,000 สาขาใกล้บ้านท่าน')
  ];
}

class _FaqPageState extends State<FaqPage> {
  final List<DetailCard> _detailcards = getDetailCards();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#FCEFE4'),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<PageResultBloc>(context)
                .add(SetButtonNavigator(true));
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: HexColor('#DB771A'),
          ),
        ),
        title: Text(
          'คำถามที่พบบ่อย',
          style: GoogleFonts.notoSansThai(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HexColor('#003063')),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor('#FCEFE4'),
                ),
                child: SvgPicture.asset('assets/faq.svg',height: 160,),
              ),
              Container(
                child: _faqDetails(),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _faqDetails() {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          var isDuplicate = _detailcards[index].isExpanded == true;
          for (var item in _detailcards) {
            item.isExpanded = false;
          }
          if (!isDuplicate) {
            _detailcards[index].isExpanded = true;
          }
        });
      },
      children: _detailcards.map<ExpansionPanel>((DetailCard DetailCard) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                DetailCard.title,
                style: GoogleFonts.notoSansThai(
                    color: HexColor('#003063'),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            );
          },
          body: ListTile(
            title: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                DetailCard.body,
                style: GoogleFonts.notoSansThai(
                    color: HexColor('#404040'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
          ),
          isExpanded: DetailCard.isExpanded,
        );
      }).toList(),
    );
  }
}
