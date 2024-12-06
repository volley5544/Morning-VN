import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'vi', 'th'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? viText = '',
    String? thText = '',
  }) =>
      [enText, viText, thText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    's9xecy5a': {
      'en': 'Home Page',
      'th': 'หน้าแรก',
      'vi': 'Trang chủ',
    },
    'atscyg3f': {
      'en': 'Promotion',
      'th': 'การส่งเสริม',
      'vi': 'Khuyến mãi',
    },
    'po3arwv4': {
      'en': 'Announecment',
      'th': 'ประกาศ',
      'vi': 'Thông báo',
    },
    'gm989c9q': {
      'en': 'Home',
      'th': 'บ้าน',
      'vi': 'Trang chủ',
    },
  },
  // loginPage
  {
    '9ac7xmrv': {
      'en': 'username',
      'th': 'ชื่อผู้ใช้',
      'vi': 'tên tài khoản',
    },
    '4m3tr4fm': {
      'en': 'password',
      'th': 'รหัสผ่าน',
      'vi': 'mật khẩu',
    },
    '3h1qkrxb': {
      'en': 'LOGIN',
      'th': 'เข้าสู่ระบบ',
      'vi': 'ĐĂNG NHẬP',
    },
    'f6exf55c': {
      'en': 'Copyright ©2024.  Srisawad Corporation Plc.',
      'th': 'ลิขสิทธิ์ ©2024. บมจ. ศรีสวัสดิ์ คอร์ปอเรชั่น',
      'vi': 'Bản quyền ©2024. Tập đoàn Srisawad Plc.',
    },
    'fboqxk9x': {
      'en': 'Home',
      'th': 'บ้าน',
      'vi': 'Trang chủ',
    },
  },
  // pinPage
  {
    'fi8l0tpk': {
      'en': 'Logout',
      'th': 'ออกจากระบบ',
      'vi': 'Đăng xuất',
    },
    'el0vuhmy': {
      'en': 'Clear Cache',
      'th': 'ล้างแคช',
      'vi': 'Xóa bộ nhớ đệm',
    },
    'ayr2w6ox': {
      'en': 'Welcome to ArunSawad',
      'th': 'ยินดีต้อนรับคุณอรุณสวัสดิ์',
      'vi': 'Chào mừng đến với ArunSawad',
    },
    'm6g8fmaa': {
      'en': 'Enter Pin to Use App',
      'th': 'ป้อน PIN เพื่อใช้แอป',
      'vi': 'Nhập mã PIN để sử dụng ứng dụng',
    },
    'rbunkr85': {
      'en': 'Home',
      'th': 'บ้าน',
      'vi': 'Trang chủ',
    },
  },
  // setPinPage
  {
    'vyizgov8': {
      'en': 'Set Your Pin',
      'th': 'ตั้งค่าพินของคุณ',
      'vi': 'Đặt mã pin của bạn',
    },
    'e81wxbhr': {
      'en': 'This Pin will Use to Enter App Next Time',
      'th': 'พินนี้จะใช้เพื่อเข้าสู่แอปในครั้งต่อไป',
      'vi': 'Ghim này sẽ sử dụng để vào ứng dụng vào lần tiếp theo',
    },
    '67idg0p8': {
      'en': 'Confirm',
      'th': 'ยืนยัน',
      'vi': 'Xác nhận',
    },
    '6xisu8bv': {
      'en': 'Home',
      'th': 'บ้าน',
      'vi': 'Trang chủ',
    },
  },
  // testlogin
  {
    'pi0m9gc4': {
      'en': 'Username',
      'th': '',
      'vi': '',
    },
    '35yjlo32': {
      'en': 'Password',
      'th': '',
      'vi': '',
    },
    'n1pjwumg': {
      'en': 'LOGIN',
      'th': '',
      'vi': '',
    },
    'ul7spu9i': {
      'en': 'Copyright ©2024.  Srisawad Corporation Plc.',
      'th': '',
      'vi': '',
    },
    '33bf2tew': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // DashboardCheckin
  {
    '2890rejr': {
      'en': 'เมนู',
      'th': '',
      'vi': '',
    },
    'rjs557r0': {
      'en': 'ลงชื่อเข้า-ออกงาน',
      'th': '',
      'vi': '',
    },
    'yjlaassc': {
      'en': 'ประวัติการเข้างาน',
      'th': '',
      'vi': '',
    },
    'zduj0m6f': {
      'en': 'เปลี่ยนพิกัด',
      'th': '',
      'vi': '',
    },
    'wub2eo13': {
      'en': 'เข้างาน - ออกงาน',
      'th': '',
      'vi': '',
    },
    'ero9jvlb': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // DashboardLeavePage
  {
    'awoy36wg': {
      'en': 'รายการลา',
      'th': '',
      'vi': '',
    },
    'km99di9u': {
      'en': 'เมนู',
      'th': '',
      'vi': '',
    },
    'gr18g86i': {
      'en': 'รายการลา',
      'th': '',
      'vi': '',
    },
    'on67qnxg': {
      'en': 'รายการขออนุมัติลา',
      'th': '',
      'vi': '',
    },
    'qx4txjds': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // CheckInStatusPage
  {
    'sgu2ax3u': {
      'en': '** สาขาที่เวลาทำการพิเศษเเละสาขาที่มีสองกะ',
      'th': '',
      'vi': '',
    },
    'w7q9015u': {
      'en': 'เเตะเพื่ออ่านเพิ่มเติม',
      'th': '',
      'vi': '',
    },
    'wul16n1i': {
      'en':
          '- ให้บันทึกเวลาในโปรเเกรมอรุณสวัสดิ์ ระบบจะส่งเวลาทำงานไปยังระบบ coach\n- ให้ตรวจสอบเวลางานผ่านระบบ coach อีกครั้งในวันถัดไป',
      'th': '',
      'vi': '',
    },
    'jyaqtfcn': {
      'en': 'เดือนปัจจุบัน',
      'th': '',
      'vi': '',
    },
    '5ele6qy2': {
      'en': 'วันที่',
      'th': '',
      'vi': '',
    },
    'xskemw5s': {
      'en': 'เข้างาน',
      'th': '',
      'vi': '',
    },
    'b5odvrkg': {
      'en': 'ออกงาน',
      'th': '',
      'vi': '',
    },
    '913wcxla': {
      'en': 'สถานะ',
      'th': '',
      'vi': '',
    },
    'fhhi2ptj': {
      'en': 'เดือนที่เเล้ว',
      'th': '',
      'vi': '',
    },
    'nkl89n6f': {
      'en': 'วันที่',
      'th': '',
      'vi': '',
    },
    'fzgyk444': {
      'en': 'เข้างาน',
      'th': '',
      'vi': '',
    },
    '04vegjgh': {
      'en': 'ออกงาน',
      'th': '',
      'vi': '',
    },
    'umt6f8p4': {
      'en': 'สถานะ',
      'th': '',
      'vi': '',
    },
    '3hp3ppc9': {
      'en': 'เวลาเข้างาน - ออกงาน',
      'th': '',
      'vi': '',
    },
    '4uatd9i3': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // LeavePage
  {
    '96do8hcg': {
      'en': 'รายการลา',
      'th': '',
      'vi': '',
    },
    'vaftq86k': {
      'en': 'ลาป่วย',
      'th': 'ลาป่วย',
      'vi': 'ลาป่วย',
    },
    'hvcoykrb': {
      'en': 'ทั้งหมด',
      'th': 'ทั้งหมด',
      'vi': 'Tất cả',
    },
    'hakrdhst': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'yofhaew7': {
      'en': 'ใช้ไป',
      'th': 'ใช้ไป',
      'vi': 'ใช้ไป',
    },
    'hcl74jy4': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'xstbiiqr': {
      'en': 'คงเหลือ',
      'th': 'คงเหลือ',
      'vi': 'คงเหลือ',
    },
    'eypwbgbv': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    '2gaa9aix': {
      'en': 'ลากิจ',
      'th': 'ลากิจ',
      'vi': 'ลากิจ',
    },
    'v7spx35u': {
      'en': ' ทั้งหมด',
      'th': 'ทั้งหมด',
      'vi': 'Tất cả',
    },
    'u55tza92': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    '948aa36n': {
      'en': 'ใช้ไป',
      'th': 'ใช้ไป',
      'vi': 'ใช้ไป',
    },
    '3p2t1tz4': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'cbj4sude': {
      'en': 'คงเหลือ',
      'th': 'คงเหลือ',
      'vi': 'คงเหลือ',
    },
    '794qegqy': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'uv0g48n7': {
      'en': 'ลาพักร้อน',
      'th': '',
      'vi': '',
    },
    'aoo0r5ci': {
      'en': ' ทั้งหมด',
      'th': 'ทั้งหมด',
      'vi': 'Tất cả',
    },
    'qpjrd0pr': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'bh0wolrr': {
      'en': 'ใช้ไป',
      'th': 'ใช้ไป',
      'vi': 'ใช้ไป',
    },
    'dtmp1zjp': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'bi1paa69': {
      'en': 'คงเหลือ',
      'th': 'คงเหลือ',
      'vi': 'คงเหลือ',
    },
    '0aa69x3j': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'kkxcueyp': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // DashBoard
  {
    'nfii7ajk': {
      'en': '1',
      'th': '',
      'vi': '',
    },
    'uwsaa34m': {
      'en': 'Thẻ môi giới bảo hiểm sẽ hết hạn trong 30 ngày.',
      'th': '',
      'vi': '',
    },
    'na0wb65k': {
      'en': 'Thẻ môi giới bảo hiểm phi nhân thọ sẽ hết hạn trong 30 ngày.',
      'th': '',
      'vi': '',
    },
    '08ugcqdn': {
      'en': 'Dịch vụ',
      'th': 'บริการ',
      'vi': 'Dịch vụ',
    },
    'wbuyhzyn': {
      'en': 'Đăng ký',
      'th': 'เช็คอิน',
      'vi': 'Đăng ký',
    },
    'vhpaflcj': {
      'en': '1',
      'th': '',
      'vi': '',
    },
    'tq9b43jh': {
      'en': 'Đơn xin nghỉ',
      'th': 'ขออนุมัติลา',
      'vi': 'Đơn xin nghỉ',
    },
    'rmile4xw': {
      'en': 'บริการ',
      'th': '',
      'vi': '',
    },
    '0j2vgbpn': {
      'en': 'เช็คอิน',
      'th': '',
      'vi': '',
    },
    '032r7heg': {
      'en': 'รางาน',
      'th': '',
      'vi': '',
    },
    'w6xmzaik': {
      'en': 'เช็คอิน',
      'th': '',
      'vi': '',
    },
    'qlcz872l': {
      'en': 'อื่นๆ',
      'th': '',
      'vi': '',
    },
    'or04md3g': {
      'en': 'เช็คอิน',
      'th': '',
      'vi': '',
    },
    'xmeui8qw': {
      'en': 'บริการ',
      'th': '',
      'vi': '',
    },
    '4mey34p5': {
      'en': 'เช็คอิน',
      'th': '',
      'vi': '',
    },
    'suyw2ruc': {
      'en': '1',
      'th': '',
      'vi': '',
    },
    'jp24p63r': {
      'en': 'ขออนุมัติลา',
      'th': '',
      'vi': '',
    },
    'a2cid5zb': {
      'en': 'ลูกค้ารถยึด',
      'th': '',
      'vi': '',
    },
    't5leiapk': {
      'en': 'Scan QRCode',
      'th': '',
      'vi': '',
    },
    'tttxylu3': {
      'en': 'Cancel',
      'th': '',
      'vi': '',
    },
    'yp4c6hdt': {
      'en': 'Cancel',
      'th': '',
      'vi': '',
    },
    '9xtt4ts5': {
      'en': 'ค่าลีดรถ M',
      'th': '',
      'vi': '',
    },
    'm5pvsibp': {
      'en': 'ลูกค้าที่ดิน',
      'th': '',
      'vi': '',
    },
    'zm9dw6sp': {
      'en': 'เส้นทางนักขายประกัน',
      'th': '',
      'vi': '',
    },
    '7epoxnwz': {
      'en': 'DSI การจ่ายงาน',
      'th': '',
      'vi': '',
    },
    'yan1dhy3': {
      'en': 'DSI HO การจ่ายงาน',
      'th': '',
      'vi': '',
    },
    'ow9lho9s': {
      'en': 'GEN E-PA',
      'th': '',
      'vi': '',
    },
    '9j7sy6s7': {
      'en': 'รายงานรถยึด',
      'th': '',
      'vi': '',
    },
    'hami3c21': {
      'en': 'โครงการ ZUVศษ',
      'th': '',
      'vi': '',
    },
    'cptksuui': {
      'en': 'ประกันนอกเรท',
      'th': '',
      'vi': '',
    },
    'exjmwxpw': {
      'en': 'รายงาน BSI',
      'th': '',
      'vi': '',
    },
    'daq28b1a': {
      'en': 'เป้า/ผลงาน',
      'th': '',
      'vi': '',
    },
    '6u6lmn09': {
      'en': 'KPI',
      'th': '',
      'vi': '',
    },
    '3pvsgfkq': {
      'en': 'ยอดจัดสาขา',
      'th': '',
      'vi': '',
    },
    'llf97pne': {
      'en': 'ยอดประกัน',
      'th': '',
      'vi': '',
    },
    '9pz1d04f': {
      'en': '!',
      'th': '',
      'vi': '',
    },
    'm032h0bx': {
      'en': 'รายชื่อลีด',
      'th': '',
      'vi': '',
    },
    'sgtxtdia': {
      'en': '%ความสำเร็จ',
      'th': '',
      'vi': '',
    },
    'fyl146uo': {
      'en': 'เช็คเบี้ยประกัน',
      'th': '',
      'vi': '',
    },
    'qqfvq3eg': {
      'en': 'Branch View',
      'th': '',
      'vi': '',
    },
    'jefx9trj': {
      'en': 'QR พนักงาน',
      'th': '',
      'vi': '',
    },
    '1krye4u7': {
      'en': 'Saleskit',
      'th': '',
      'vi': '',
    },
    '4j35yu3u': {
      'en': 'ฟอร์มลีด',
      'th': '',
      'vi': '',
    },
    'w2p21nke': {
      'en': 'โปรโมชั่น',
      'th': '',
      'vi': '',
    },
    'pq7t9adp': {
      'en': 'COACH',
      'th': '',
      'vi': '',
    },
    '4m2jwphv': {
      'en': 'ห้องเรียนทันใจ',
      'th': '',
      'vi': '',
    },
    'o5bwgd56': {
      'en': 'ข้อมูลไอที',
      'th': '',
      'vi': '',
    },
    '7lcu5obv': {
      'en': 'Incentive สาขา',
      'th': '',
      'vi': '',
    },
    'wyas8k5z': {
      'en': '06-10-2022',
      'th': '',
      'vi': '',
    },
    'xp179dg2': {
      'en': 'โปรโมชั่น การขายพิเศษ',
      'th': '',
      'vi': '',
    },
    'weds1r6d': {
      'en': 'Incentive สาขา',
      'th': '',
      'vi': '',
    },
    '9jz2vnof': {
      'en': '06-10-2022',
      'th': '',
      'vi': '',
    },
    'unf1wxk6': {
      'en': 'โปรโมชั่น การขายพิเศษ',
      'th': '',
      'vi': '',
    },
    'gq0mnfr3': {
      'en': 'version 1.0.0',
      'th': 'version 1.0.0',
      'vi': 'version 1.0.0',
    },
    'cvg8gweh': {
      'en': 'android',
      'th': 'android',
      'vi': 'android',
    },
    'tzmiupgy': {
      'en': 'Log out',
      'th': 'ออกจากระบบ',
      'vi': 'Log out',
    },
    'imxzxcpq': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'norah8ri': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // EmpolyeeCheckin
  {
    'dib97xps': {
      'en': 'ลงเวลางาน',
      'th': '',
      'vi': '',
    },
    '1nfjeid0': {
      'en': 'เลือก: ',
      'th': '',
      'vi': '',
    },
    'g8kgz1my': {
      'en': 'สถานที่เช็คอิน...',
      'th': '',
      'vi': '',
    },
    'e5yri805': {
      'en': 'สาขาที่จะเช็คอิน ...',
      'th': '',
      'vi': '',
    },
    'k25vdgx1': {
      'en': 'เหตุผล:',
      'th': '',
      'vi': '',
    },
    'n3lk5dy4': {
      'en': 'กรุณากรอกเหตุผล',
      'th': '',
      'vi': '',
    },
    'hgcupj9q': {
      'en': 'ลงเวลางาน',
      'th': '',
      'vi': '',
    },
    '3yqz7123': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // AddLeavePage
  {
    'vz6y5of2': {
      'en': 'ยื่นเรื่องขออนุมัติ',
      'th': '',
      'vi': '',
    },
    'b9538lpc': {
      'en': 'วันที่ลาเริ่มต้น :',
      'th': '',
      'vi': '',
    },
    '0elhhiqw': {
      'en': 'ช่วงเวลา :',
      'th': '',
      'vi': '',
    },
    'irupdmbb': {
      'en': 'กรุณาเลือก...',
      'th': '',
      'vi': '',
    },
    'bkl4yvb7': {
      'en': 'Search...',
      'th': '',
      'vi': '',
    },
    '937nv8jq': {
      'en': 'ใส่จำนวนวันที่ต้องการลา',
      'th': '',
      'vi': '',
    },
    '3kgjydml': {
      'en': 'เบอร์โทรติดต่อ :',
      'th': '',
      'vi': '',
    },
    'hsst7oqz': {
      'en': 'กรุณากรอกเบอร์โทรศัพท์',
      'th': '',
      'vi': '',
    },
    '8om1wy4i': {
      'en': 'เหตุผลการลา :',
      'th': '',
      'vi': '',
    },
    'r5aq23yf': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'gt2y7n4a': {
      'en': 'กรุณากรอก...',
      'th': '',
      'vi': '',
    },
    'q3c9wvz6': {
      'en': 'แนบไฟล์การลา :',
      'th': '',
      'vi': '',
    },
    'znmc7q82': {
      'en': '[เเนบไฟล์ภาพ]',
      'th': '',
      'vi': '',
    },
    'ouvrw7wb': {
      'en': 'บันทึก',
      'th': '',
      'vi': '',
    },
    'hw7uo3w2': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // leaveShowPage
  {
    'khbxc7ss': {
      'en': 'รายการขออนุมัติ',
      'th': '',
      'vi': '',
    },
    'mlia1ki1': {
      'en': 'นายสุรพิชญา มุ่งเกิด',
      'th': '',
      'vi': '',
    },
    'bfni9e49': {
      'en': 'ประเภทการลา:',
      'th': '',
      'vi': '',
    },
    '29pf8q9b': {
      'en': '[ลากิจ]',
      'th': '',
      'vi': '',
    },
    'xy9onwfi': {
      'en': 'วันที่ทำรายการ:',
      'th': '',
      'vi': '',
    },
    'z4eyg5my': {
      'en': '[10/11/257]',
      'th': '',
      'vi': '',
    },
    'bmrd0rht': {
      'en': 'วันที่ลา:',
      'th': '',
      'vi': '',
    },
    'k1k6az6n': {
      'en': '[19/11/2567-20/11/2567]',
      'th': '',
      'vi': '',
    },
    'rjrpncss': {
      'en': 'จำนวนวันที่ลา:',
      'th': '',
      'vi': '',
    },
    '8cyq2avl': {
      'en': '[2]',
      'th': '',
      'vi': '',
    },
    'gq8o1yug': {
      'en': 'ช่วงเวลา:',
      'th': '',
      'vi': '',
    },
    '27o8bui4': {
      'en': '[ลาเต็มวัน]',
      'th': '',
      'vi': '',
    },
    '2vv061k1': {
      'en': 'เหตุผลการลา:',
      'th': '',
      'vi': '',
    },
    '62t9k3ud': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    'xyx1pgqi': {
      'en': 'ผู้อนุมัติ:',
      'th': '',
      'vi': '',
    },
    '5wvudasy': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    '3435iaid': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    'y41pb3gc': {
      'en': 'สถานะ:',
      'th': '',
      'vi': '',
    },
    'ka6tgpdu': {
      'en': '[รอดำเนินการ]',
      'th': '',
      'vi': '',
    },
    '5r04t7id': {
      'en': 'ไฟล์เเนบ:',
      'th': '',
      'vi': '',
    },
    'lroplpyc': {
      'en': 'แก้ไข',
      'th': '',
      'vi': '',
    },
    'yrzcj3jl': {
      'en': 'ยกเลิก',
      'th': '',
      'vi': '',
    },
    'ycvzb83m': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // EditLeavePage
  {
    '3s87m5yx': {
      'en': 'ยื่นเรื่องขออนุมัติ',
      'th': '',
      'vi': '',
    },
    'od7tp6s4': {
      'en': 'ประเภทการลา : ',
      'th': '',
      'vi': '',
    },
    '6ab0k4ay': {
      'en': 'วันที่ลาเริ่มต้น :',
      'th': '',
      'vi': '',
    },
    '6qo2iyv8': {
      'en': 'ระบุวันที่',
      'th': '',
      'vi': '',
    },
    'eggk5pnq': {
      'en': 'ช่วงเวลา :',
      'th': '',
      'vi': '',
    },
    'wyd50c1m': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    'lqaxawpl': {
      'en': 'Option 2',
      'th': '',
      'vi': '',
    },
    'gb2d3owg': {
      'en': 'Option 3',
      'th': '',
      'vi': '',
    },
    '7aqnk1ld': {
      'en': 'กรุณาเลือก...',
      'th': '',
      'vi': '',
    },
    'z1sdh1sr': {
      'en': 'Search...',
      'th': '',
      'vi': '',
    },
    'i8cw499x': {
      'en': 'ใส่จำนวนวันที่ต้องการลา',
      'th': '',
      'vi': '',
    },
    's8zjhfy2': {
      'en': 'เบอร์โทรติดต่อ :',
      'th': '',
      'vi': '',
    },
    'ha4k3i3t': {
      'en': 'กรุณากรอกเบอร์โทรศัพท์',
      'th': '',
      'vi': '',
    },
    'g7ay52et': {
      'en': 'เหตุผลการลา :',
      'th': '',
      'vi': '',
    },
    'afe57qmx': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'trc3jz7r': {
      'en': 'กรุณากรอก...',
      'th': '',
      'vi': '',
    },
    'f9wpd6zy': {
      'en': 'แนบไฟล์การลา :',
      'th': '',
      'vi': '',
    },
    'zoen0z04': {
      'en': '[เเนบไฟล์ภาพ]',
      'th': '',
      'vi': '',
    },
    'jegp9wff': {
      'en': 'บันทึก',
      'th': '',
      'vi': '',
    },
    'u8ph3ko2': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // ChangeLatLngPage
  {
    'ow65a9dm': {
      'en': 'รหัสสาขา:',
      'th': '',
      'vi': '',
    },
    'mda334g6': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'ys1nicdw': {
      'en': 'กรอกรหัสสาขา',
      'th': '',
      'vi': '',
    },
    '3zbhrtsz': {
      'en': 'ละติจูด ใหม่:',
      'th': '',
      'vi': '',
    },
    'ujz0ux2p': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'p8e64plt': {
      'en': 'กรอกละติจูด',
      'th': '',
      'vi': '',
    },
    'kgjyms41': {
      'en': 'ลองจิจูด ใหม่:',
      'th': '',
      'vi': '',
    },
    'tnk17wa1': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'gpgeky4b': {
      'en': 'กรอกลองจิจูด',
      'th': '',
      'vi': '',
    },
    'eq31tpvr': {
      'en': 'ค้นหา',
      'th': '',
      'vi': '',
    },
    'al0dzpl0': {
      'en': 'ระยะห่าง:',
      'th': '',
      'vi': '',
    },
    '1k3jmyrr': {
      'en': '0',
      'th': '',
      'vi': '',
    },
    'nbhpres0': {
      'en': 'พิกัดเก่า',
      'th': '',
      'vi': '',
    },
    'dh5tylyg': {
      'en': 'พิกัดใหม่',
      'th': '',
      'vi': '',
    },
    '68dxb7jg': {
      'en': 'บันทึก',
      'th': '',
      'vi': '',
    },
    'ud7qpnr0': {
      'en': 'Change Lat,Lng',
      'th': '',
      'vi': '',
    },
    '2j9o1nc7': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // myProfilePage
  {
    '7c59mcgf': {
      'en': 'คู่มือพนักงาน',
      'th': 'คู่มือพนักงาน',
      'vi': 'Sổ tay nhân viên',
    },
    'ubz6qsvt': {
      'en': 'Profile',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // GuideBookPage
  {
    'hc3lnn2n': {
      'en': 'คู่มือพนักงาน',
      'th': '',
      'vi': '',
    },
    'dydg99w9': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // NotificationPage
  {
    'jhipmg5z': {
      'en': 'การแจ้งเตือน',
      'th': '',
      'vi': '',
    },
    '2ilbxx1d': {
      'en': 'คำขออนุมัติการลา',
      'th': '',
      'vi': '',
    },
    'zg791631': {
      'en': '18:39 น.',
      'th': '',
      'vi': '',
    },
    'n9zwmkux': {
      'en': 'คำขอ \'ลาป่วย\' ของคุณได้รับการอนุมัติแล้ว ',
      'th': '',
      'vi': '',
    },
    't491ogrv': {
      'en': '4/1/2024',
      'th': '',
      'vi': '',
    },
    'zepnrqjg': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // SuccessCheckinPage
  {
    'a4jv1rkh': {
      'en': 'สำเร็จ!',
      'th': '',
      'vi': '',
    },
    'dm3qluv6': {
      'en': 'บันทึกข้อมูลเสร็จสิ้น',
      'th': '',
      'vi': '',
    },
    '0p889zk0': {
      'en': 'กลับหน้าหลัก',
      'th': '',
      'vi': '',
    },
    'ep6jzjsj': {
      'en': 'เช็คสถานะ',
      'th': '',
      'vi': '',
    },
    'b14q64lh': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // EmployeeCheckinPageVol
  {
    'zmdkvqhu': {
      'en': 'วันจันทร์ , 2 ธันวาคม 2567',
      'th': '',
      'vi': '',
    },
    'i8gdmckz': {
      'en': '13 : 41 : 35 น.',
      'th': '',
      'vi': '',
    },
    'l6blpkdm': {
      'en': 'สถานที่เช็คอิน',
      'th': '',
      'vi': '',
    },
    'z7nsnw7q': {
      'en': ':',
      'th': '',
      'vi': '',
    },
    's3yychni': {
      'en': 'สถานที่เช็คอิน',
      'th': '',
      'vi': '',
    },
    'lzjrurt0': {
      'en': ':',
      'th': '',
      'vi': '',
    },
    'sfn0qwg3': {
      'en': 'สำนักงานใหญ่ แจ้งวัฒนะ',
      'th': '',
      'vi': '',
    },
    '624240jw': {
      'en': 'บ้าน',
      'th': '',
      'vi': '',
    },
    'f19jf9yj': {
      'en': 'เลือก...',
      'th': '',
      'vi': '',
    },
    '1551rr5u': {
      'en': 'Search...',
      'th': '',
      'vi': '',
    },
    'ftoe9e4u': {
      'en': 'หมายเหตุ',
      'th': '',
      'vi': '',
    },
    '9xzwtf7m': {
      'en': ':',
      'th': '',
      'vi': '',
    },
    '71z45b5q': {
      'en': 'หมายเหตุ...',
      'th': '',
      'vi': '',
    },
    'vsxa3kfb': {
      'en': 'ลงเวลา',
      'th': '',
      'vi': '',
    },
    'daobyp58': {
      'en': 'เช็คอินเข้า - ออกงาน',
      'th': '',
      'vi': '',
    },
    'j06y3w7b': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // CheckinStatusPageVol
  {
    'fqbu66eb': {
      'en': 'เดือนปัจจุบัน',
      'th': '',
      'vi': '',
    },
    'zuaoy20t': {
      'en': 'No Data ',
      'th': '',
      'vi': '',
    },
    'z88z2cj0': {
      'en': 'เดือนที่แล้ว',
      'th': '',
      'vi': '',
    },
    'v4obacrw': {
      'en': 'No Data',
      'th': '',
      'vi': '',
    },
    'gldh814t': {
      'en': 'รายการเช็คอิน',
      'th': '',
      'vi': '',
    },
    'ef7fqaz2': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // TestPage
  {
    'twf4yttl': {
      'en': 'Page Title',
      'th': '',
      'vi': '',
    },
    'jnr40cz6': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // Test2Page
  {
    'ptmrpe6b': {
      'en': 'จ. 2 ธ.ค. 67',
      'th': '',
      'vi': '',
    },
    '5bjbdja6': {
      'en': '08:30',
      'th': '',
      'vi': '',
    },
    'ks6296oy': {
      'en': '17:30',
      'th': '',
      'vi': '',
    },
    '09v773m6': {
      'en': 'Page Title',
      'th': '',
      'vi': '',
    },
    'zkc9h90s': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // searchBranchPage
  {
    '9jepmg79': {
      'en': 'กรุณากรอกคำค้นหา',
      'th': '',
      'vi': '',
    },
    'wuqoiaft': {
      'en': 'ค้นหา',
      'th': '',
      'vi': '',
    },
    'gztk5uiq': {
      'en': 'กรุณากรอกคำค้นหาอย่างน้อย 3 ตัวอักษร',
      'th': '',
      'vi': '',
    },
    'l8tbvzm7': {
      'en': 'ค้นหาสาขา',
      'th': '',
      'vi': '',
    },
    'o31gdg36': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // Action2SheetSimple
  {
    'inom8wzb': {
      'en': 'Edit Post',
      'th': '',
      'vi': '',
    },
    '2s6f3pou': {
      'en': 'Delete Story',
      'th': '',
      'vi': '',
    },
    '7jf1gs62': {
      'en': 'Cancel',
      'th': '',
      'vi': '',
    },
  },
  // StatusCompnent
  {
    '7ul9r41x': {
      'en': 'สถานะทั้งหมด',
      'th': '',
      'vi': '',
    },
    'mqn06a20': {
      'en': 'เช็คอินเข้า-ออกงาน จะมีเเถบเเละสถานะดังนี้',
      'th': '',
      'vi': '',
    },
    'kh7en1yk': {
      'en': 'วันหยุดเเละวันหยุดตามประเพณี',
      'th': '',
      'vi': '',
    },
    '0il619bg': {
      'en': 'ขาดงาน',
      'th': '',
      'vi': '',
    },
    '3py39tbc': {
      'en': 'ลงเวลาไม่ครบ(ไม่เช็คเอาท์ออกงาน)',
      'th': '',
      'vi': '',
    },
    'q4nj7lx7': {
      'en': 'เข้างานไม่ครบจำนวน(ทำงานไม่ครบ 8 ชั่วโมง)',
      'th': '',
      'vi': '',
    },
    '0g6rkfn2': {
      'en': 'สาย (เช็คอินหลังเวลาเข้างาน)',
      'th': '',
      'vi': '',
    },
    'fn4vqph9': {
      'en': 'ออกก่อนเวลา (เช็คเอาท์ก่อนเวลาเลิกงาน)',
      'th': '',
      'vi': '',
    },
    '5qzqlkly': {
      'en': 'ปกติ',
      'th': '',
      'vi': '',
    },
  },
  // CheckinDataTableComponent
  {
    '16oepeuj': {
      'en': 'วันที่',
      'th': '',
      'vi': '',
    },
    '0zrm148v': {
      'en': 'เข้างาน',
      'th': '',
      'vi': '',
    },
    'sj9ejuz4': {
      'en': 'ออกงาน',
      'th': '',
      'vi': '',
    },
    'quvmv0kc': {
      'en': 'สถานะ',
      'th': '',
      'vi': '',
    },
  },
  // PDFViewer
  {
    '8hrqora5': {
      'en': '',
      'th': '',
      'vi': '',
    },
  },
  // searchBranchComponent
  {
    'ommo80jx': {
      'en': 'กรุณากรอกคำค้นหา',
      'th': '',
      'vi': '',
    },
  },
  // serchBranchComponentCheckin
  {
    'la9fs10d': {
      'en': 'กรุณากรอกชื่อสาขา',
      'th': '',
      'vi': '',
    },
  },
  // Miscellaneous
  {
    '80tv2pc9': {
      'en': 'Please allow to access your location to tracking your work',
      'th': '',
      'vi': '',
    },
    'o3sn8b72': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'b3e6er6g': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'vwkkokli': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '4a3g89bn': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'iyvmez0d': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '9irxlbie': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'fr4soeui': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '5efnfdl9': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '3n9pnazs': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'w9iq5r7h': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '9nbctlia': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'tipctwgv': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'x23gjpnz': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'io35f5qm': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'vah30gmz': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'k7glerk4': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '0tbtbjnc': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '5qtuwpic': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'rc0fv5cd': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'biye60jp': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'qqc2lky5': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'cgk3l6v7': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '8zvzsp8f': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'c46q7zgh': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'b1gbuf20': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'pz13sxpx': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '0ld8qwzr': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'ilotczoj': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'ri9ycwhf': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '8wjpbeh1': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'koy9v0j5': {
      'en': '',
      'th': '',
      'vi': '',
    },
  },
].reduce((a, b) => a..addAll(b));
