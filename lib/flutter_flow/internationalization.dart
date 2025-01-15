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
      'vi': 'Tên người dùng (username)',
    },
    '4m3tr4fm': {
      'en': 'password',
      'th': 'รหัสผ่าน',
      'vi': 'Mật khẩu (password)',
    },
    '3h1qkrxb': {
      'en': 'LOGIN',
      'th': 'เข้าสู่ระบบ',
      'vi': 'Đăng nhập',
    },
    'f6exf55c': {
      'en': 'Copyright ©2024.  Srisawad Corporation Plc.',
      'th': 'ลิขสิทธิ์ ©2024. บมจ. ศรีสวัสดิ์ คอร์ปอเรชั่น',
      'vi': 'Bản quyền © 2024 Srisawad Corporation Plc.',
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
      'vi': 'Xóa dữ liệu',
    },
    'ayr2w6ox': {
      'en': 'Welcome to ArunSawad',
      'th': 'ยินดีต้อนรับคุณอรุณสวัสดิ์',
      'vi': 'Chào mừng đến với Morning VN',
    },
    'm6g8fmaa': {
      'en': 'Enter Pin to Use App',
      'th': 'ป้อน PIN เพื่อใช้แอป',
      'vi': 'Vui lòng nhập mã PIN để đăng nhập',
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
      'vi': 'Đặt mã PIN của bạn',
    },
    'e81wxbhr': {
      'en': 'This Pin will Use to Enter App Next Time',
      'th': 'พินนี้จะใช้เพื่อเข้าสู่แอปในครั้งต่อไป',
      'vi': 'Mã PIN này sẽ được sử dụng để đăng nhập vào lần tiếp theo',
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
      'en': 'Menu',
      'th': 'เมนู',
      'vi': 'Menu',
    },
    'rjs557r0': {
      'en': 'Check in-out',
      'th': 'ลงชื่อเข้า-ออกงาน',
      'vi': 'Chấm Công Vào - Ra',
    },
    'yjlaassc': {
      'en': 'Check-in history',
      'th': 'ประวัติการเข้างาน',
      'vi': 'Lịch sử chấm công',
    },
    'zduj0m6f': {
      'en': 'Change location',
      'th': 'เปลี่ยนพิกัด',
      'vi': 'Thay đổi vị trí',
    },
    'wub2eo13': {
      'en': 'Check in - Check out',
      'th': 'เข้างาน - ออกงาน',
      'vi': 'Chấm Công Vào - Ra',
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
      'en': 'Leave list',
      'th': 'รายการลา',
      'vi': 'รายการลา',
    },
    'km99di9u': {
      'en': 'Menu',
      'th': 'เมนู',
      'vi': 'Menu',
    },
    'gr18g86i': {
      'en': 'Leave list',
      'th': 'รายการลา',
      'vi': 'รายการลา',
    },
    'on67qnxg': {
      'en': 'Leave approval request list',
      'th': 'รายการขออนุมัติลา',
      'vi': 'รายการขออนุมัติลา',
    },
    'k5qkxo1i': {
      'en': 'Leave approval',
      'th': 'อนุมัติการลา',
      'vi': 'อนุมัติการลา',
    },
    '5jeqd5gu': {
      'en': 'Approved leave list',
      'th': 'รายการที่อนุมัติลา',
      'vi': 'รายการที่อนุมัติลา',
    },
    'k91i2ssy': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // CheckInStatusPage
  {
    'sgu2ax3u': {
      'en':
          '** Branches with special operating hours and branches with two shifts.',
      'th': '** สาขาที่เวลาทำการพิเศษเเละสาขาที่มีสองกะ',
      'vi': '**Chi nhánh có thời gian làm việc đặc biệt và chi nhánh có hai ca',
    },
    'w7q9015u': {
      'en': 'Tap to read more',
      'th': 'เเตะเพื่ออ่านเพิ่มเติม',
      'vi': 'Nhấn để đọc thêm',
    },
    'wul16n1i': {
      'en':
          '- ให้บันทึกเวลาในโปรเเกรมอรุณสวัสดิ์ ระบบจะส่งเวลาทำงานไปยังระบบ coach\n- ให้ตรวจสอบเวลางานผ่านระบบ coach อีกครั้งในวันถัดไป',
      'th': '',
      'vi':
          'Vui lòng ghi lại thời gian làm việc trong chương trình Arun Sawat, hệ thống sẽ gửi thời gian làm việc đến hệ thống coach.',
    },
    'jyaqtfcn': {
      'en': 'Current month',
      'th': 'เดือนปัจจุบัน',
      'vi': 'Tháng hiện tại',
    },
    '5ele6qy2': {
      'en': 'วันที่',
      'th': '',
      'vi': 'Ngày',
    },
    'xskemw5s': {
      'en': 'เข้างาน',
      'th': '',
      'vi': 'Vào ca',
    },
    'b5odvrkg': {
      'en': 'ออกงาน',
      'th': '',
      'vi': 'Tan ca',
    },
    '913wcxla': {
      'en': 'สถานะ',
      'th': '',
      'vi': 'Trạng thái',
    },
    'fhhi2ptj': {
      'en': 'Last month',
      'th': 'เดือนที่แล้ว',
      'vi': 'Tháng trước',
    },
    'nkl89n6f': {
      'en': 'Date',
      'th': 'วันที่',
      'vi': 'Ngày',
    },
    'fzgyk444': {
      'en': 'Clock in',
      'th': 'เข้างาน',
      'vi': 'Vào ca',
    },
    '04vegjgh': {
      'en': 'Clock out',
      'th': 'ออกงาน',
      'vi': 'Tan ca',
    },
    'umt6f8p4': {
      'en': 'Status',
      'th': 'สถานะ',
      'vi': 'Trạng thái',
    },
    '3hp3ppc9': {
      'en': 'Clock-in/out Time',
      'th': 'เวลาเข้างาน - ออกงาน',
      'vi': 'Thời gian vào ca - tan ca',
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
    'hvcoykrb': {
      'en': 'All',
      'th': 'ทั้งหมด',
      'vi': 'Tổng số',
    },
    'yofhaew7': {
      'en': 'Used',
      'th': 'ใช้ไป',
      'vi': 'Đã sử dụng',
    },
    'xstbiiqr': {
      'en': 'Remaining',
      'th': 'คงเหลือ',
      'vi': 'Còn lại',
    },
    'kkxcueyp': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // superAppPage
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
      'en': 'Service',
      'th': 'บริการ',
      'vi': 'Dịch vụ',
    },
    'wbuyhzyn': {
      'en': 'Check-in',
      'th': 'เช็คอิน',
      'vi': 'Check-in',
    },
    'vhpaflcj': {
      'en': '1',
      'th': '',
      'vi': '',
    },
    'tq9b43jh': {
      'en': 'Leave Request',
      'th': 'ขออนุมัติลา',
      'vi': 'Đơn xin nghỉ',
    },
    'xmeui8qw': {
      'en': 'บริการ',
      'th': '',
      'vi': 'Dịch vụ',
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
      'en': 'Language Settings',
      'th': 'เปลี่ยนภาษา',
      'vi': 'Cài đặt ngôn ngữ',
    },
    'imxzxcpq': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'clybdejr': {
      'en': 'Log Out',
      'th': 'ออกจากระบบ',
      'vi': 'Đăng xuất',
    },
    'uyn6knsr': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'norah8ri': {
      'en': 'Home',
      'th': 'Home',
      'vi': 'TRANG CHỦ',
    },
  },
  // EmpolyeeCheckin
  {
    'dib97xps': {
      'en': 'Clock in/Clock out',
      'th': 'ลงเวลางาน',
      'vi': 'Chấm công',
    },
    '1nfjeid0': {
      'en': 'Select: ',
      'th': 'เลือก: ',
      'vi': 'Chọn: ',
    },
    'g8kgz1my': {
      'en': 'Check-in location...',
      'th': 'สถานที่เช็คอิน...',
      'vi': 'địa điểm check-in',
    },
    'e5yri805': {
      'en': 'สาขาที่จะเช็คอิน ...',
      'th': '',
      'vi': 'nhánh...',
    },
    'k25vdgx1': {
      'en': 'Reason:',
      'th': 'เหตุผล:',
      'vi': 'Lý do:',
    },
    'n3lk5dy4': {
      'en': 'Please provide a reason.',
      'th': 'กรุณากรอกเหตุผล',
      'vi': 'Ô: Vui lòng nhập lý do',
    },
    'p5c17osm': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'hgcupj9q': {
      'en': 'Clock in-out',
      'th': 'ลงเวลางาน',
      'vi': 'Đăng ký giờ làm việc',
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
      'en': 'Submit approval request',
      'th': 'ยื่นเรื่องขออนุมัติ',
      'vi': 'ยื่นเรื่องขออนุมัติ',
    },
    'b9538lpc': {
      'en': 'วันที่ลา :',
      'th': 'วันที่ลา :',
      'vi': 'วันที่ลา :',
    },
    '0elhhiqw': {
      'en': 'ช่วงเวลา :',
      'th': 'ช่วงเวลา :',
      'vi': 'ช่วงเวลา :',
    },
    'irupdmbb': {
      'en': 'กรุณาเลือก...',
      'th': 'กรุณาเลือก...',
      'vi': 'กรุณาเลือก...',
    },
    'bkl4yvb7': {
      'en': 'Search...',
      'th': '',
      'vi': '',
    },
    '3kgjydml': {
      'en': 'เบอร์โทรติดต่อ :',
      'th': 'เบอร์โทรติดต่อ :',
      'vi': 'เบอร์โทรติดต่อ :',
    },
    'hsst7oqz': {
      'en': 'กรุณากรอกเบอร์โทรศัพท์',
      'th': 'กรุณากรอกเบอร์โทรศัพท์',
      'vi': 'กรุณากรอกเบอร์โทรศัพท์',
    },
    '63k8f7ok': {
      'en': 'กรุณากรอกเบอร์โทรศัพท์',
      'th': '',
      'vi': '',
    },
    '5tu2ewa8': {
      'en': 'Please choose an option from the dropdown',
      'th': '',
      'vi': '',
    },
    '8om1wy4i': {
      'en': 'เหตุผลการลา :',
      'th': 'เหตุผลการลา :',
      'vi': 'เหตุผลการลา :',
    },
    '2xngye0q': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '8gbpsn0a': {
      'en': 'กรุณากรอก...',
      'th': 'กรุณากรอก...',
      'vi': 'กรุณากรอก...',
    },
    'q3c9wvz6': {
      'en': 'แนบไฟล์การลา :',
      'th': '',
      'vi': '',
    },
    'znmc7q82': {
      'en': '[เเนบไฟล์ภาพ]',
      'th': '[เเนบไฟล์ภาพ]',
      'vi': '[เเนบไฟล์ภาพ]',
    },
    'ouvrw7wb': {
      'en': 'บันทึก',
      'th': 'บันทึก',
      'vi': 'บันทึก',
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
      'en': 'Approval request list',
      'th': 'รายการขออนุมัติ',
      'vi': '',
    },
    'hnu9wndq': {
      'en': 'Please select the month you want to search for',
      'th': 'กรุณาเลือกเดือนที่ต้องการหา',
      'vi': 'กรุณาเลือกเดือนที่ต้องการหา',
    },
    'gbupk547': {
      'en': 'มกราคม',
      'th': 'มกราคม',
      'vi': 'มกราคม',
    },
    'qyu0cqfp': {
      'en': 'กุมภาพันธ์',
      'th': 'กุมภาพันธ์',
      'vi': 'กุมภาพันธ์',
    },
    'ell27mzr': {
      'en': 'มีนาคม',
      'th': 'มีนาคม',
      'vi': 'มีนาคม',
    },
    '3524vv4b': {
      'en': 'เมษายน',
      'th': 'เมษายน',
      'vi': 'เมษายน',
    },
    '8pioxviy': {
      'en': 'พฤษภาคม',
      'th': 'พฤษภาคม',
      'vi': 'พฤษภาคม',
    },
    '3hstfuhu': {
      'en': 'มิถุนายน',
      'th': 'มิถุนายน',
      'vi': 'มิถุนายน',
    },
    'nfk5kp23': {
      'en': 'กรกฎาคม',
      'th': 'กรกฎาคม',
      'vi': 'กรกฎาคม',
    },
    '0zv18zxh': {
      'en': 'สิงหาคม',
      'th': 'สิงหาคม',
      'vi': 'สิงหาคม',
    },
    '5r8kjjcw': {
      'en': 'กันยายน',
      'th': 'กันยายน',
      'vi': 'กันยายน',
    },
    '42mrkdha': {
      'en': 'ตุลาคม',
      'th': 'ตุลาคม',
      'vi': 'ตุลาคม',
    },
    'qmmnb3ms': {
      'en': 'พฤศจิกายน',
      'th': 'พฤศจิกายน',
      'vi': 'พฤศจิกายน',
    },
    '6zsnfvum': {
      'en': 'ธันวาคม',
      'th': 'ธันวาคม',
      'vi': 'ธันวาคม',
    },
    'at82sxc8': {
      'en': 'Leave',
      'th': 'ลา',
      'vi': 'ลา',
    },
    'bfni9e49': {
      'en': 'Type of leave:',
      'th': 'ประเภทการลา:',
      'vi': 'Loại nghỉ phép:',
    },
    'xy9onwfi': {
      'en': 'Transaction date:',
      'th': 'วันที่ทำรายการ:',
      'vi': 'Ngày thực hiện giao dịch:',
    },
    'bmrd0rht': {
      'en': 'Leave date:',
      'th': 'วันที่ลา:',
      'vi': 'Ngày nghỉ:',
    },
    'rjrpncss': {
      'en': 'Number of leave days:',
      'th': 'จำนวนวันที่ลา:',
      'vi': 'Số ngày nghỉ',
    },
    'gq8o1yug': {
      'en': 'Period of time:',
      'th': 'ช่วงเวลา:',
      'vi': 'Khoảng thời gian:',
    },
    '2vv061k1': {
      'en': 'Reason for leave:',
      'th': 'เหตุผลการลา:',
      'vi': '',
    },
    'xyx1pgqi': {
      'en': 'Approver:',
      'th': 'ผู้อนุมัติ:',
      'vi': '',
    },
    'y41pb3gc': {
      'en': 'Status:',
      'th': 'สถานะ:',
      'vi': '',
    },
    '5r04t7id': {
      'en': 'Attached file:',
      'th': 'ไฟล์เเนบ:',
      'vi': '',
    },
    'lroplpyc': {
      'en': 'Edit',
      'th': 'แก้ไข',
      'vi': '',
    },
    'yrzcj3jl': {
      'en': 'Cancel',
      'th': 'ยกเลิก',
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
    '6ab0k4ay': {
      'en': 'วันที่ลาเริ่มต้น :',
      'th': 'วันที่ลาเริ่มต้น :',
      'vi': 'วันที่ลาเริ่มต้น :',
    },
    'eggk5pnq': {
      'en': 'ช่วงเวลา :',
      'th': 'ช่วงเวลา :',
      'vi': 'ช่วงเวลา :',
    },
    '84tw9mm6': {
      'en': 'กรุณาเลือก...',
      'th': 'กรุณาเลือก...',
      'vi': 'กรุณาเลือก...',
    },
    '2ifmdsd0': {
      'en': 'Search...',
      'th': '',
      'vi': '',
    },
    '03inv98e': {
      'en': 'ลาเต็มวัน',
      'th': 'ลาเต็มวัน',
      'vi': 'ลาเต็มวัน',
    },
    'oy5uij8u': {
      'en': 'ลาครึ่งวันเช้า',
      'th': 'ลาครึ่งวันเช้า',
      'vi': 'ลาครึ่งวันเช้า',
    },
    'povs34al': {
      'en': 'ลาครึ่งวันบ่าย',
      'th': 'ลาครึ่งวันบ่าย',
      'vi': 'ลาครึ่งวันบ่าย',
    },
    'kvgvg8v2': {
      'en': 'TextField',
      'th': '',
      'vi': '',
    },
    's8zjhfy2': {
      'en': 'เบอร์โทรติดต่อ :',
      'th': 'เบอร์โทรติดต่อ :',
      'vi': 'เบอร์โทรติดต่อ :',
    },
    'ha4k3i3t': {
      'en': 'กรุณากรอกเบอร์โทรศัพท์',
      'th': 'กรุณากรอกเบอร์โทรศัพท์',
      'vi': 'กรุณากรอกเบอร์โทรศัพท์',
    },
    'g7ay52et': {
      'en': 'เหตุผลการลา :',
      'th': 'เหตุผลการลา :',
      'vi': 'เหตุผลการลา :',
    },
    'afe57qmx': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'trc3jz7r': {
      'en': 'กรุณากรอก...',
      'th': 'กรุณากรอก...',
      'vi': 'กรุณากรอก...',
    },
    'f9wpd6zy': {
      'en': 'แนบไฟล์การลา :',
      'th': 'แนบไฟล์การลา :',
      'vi': 'แนบไฟล์การลา :',
    },
    'zoen0z04': {
      'en': '[เเนบไฟล์ภาพ]',
      'th': '[เเนบไฟล์ภาพ]',
      'vi': '[เเนบไฟล์ภาพ]',
    },
    'jegp9wff': {
      'en': 'บันทึก',
      'th': 'บันทึก',
      'vi': 'บันทึก',
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
      'en': 'Branch code:',
      'th': 'รหัสสาขา:',
      'vi': 'Mã chi nhánh:',
    },
    'mda334g6': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'ys1nicdw': {
      'en': 'Please enter branch code',
      'th': 'กรอกรหัสสาขา',
      'vi': 'Ô nhập mã chi nhánh',
    },
    '3zbhrtsz': {
      'en': 'New latitude:',
      'th': 'ละติจูด ใหม่:',
      'vi': 'Vĩ độ mới',
    },
    'ujz0ux2p': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'p8e64plt': {
      'en': 'Please enter latitude',
      'th': 'กรอกละติจูด',
      'vi': 'Ô nhập vĩ độ',
    },
    'kgjyms41': {
      'en': 'New longitude:',
      'th': 'ลองจิจูด ใหม่:',
      'vi': 'Kinh độ mới:',
    },
    'tnk17wa1': {
      'en': '',
      'th': '',
      'vi': '',
    },
    'gpgeky4b': {
      'en': 'Please enter longitude',
      'th': 'กรอกลองจิจูด',
      'vi': 'Ô nhập kinh độ',
    },
    'eq31tpvr': {
      'en': 'Search',
      'th': 'ค้นหา',
      'vi': 'Tìm kiếm',
    },
    'al0dzpl0': {
      'en': 'Distance:',
      'th': 'ระยะห่าง:',
      'vi': 'Khoảng cách:',
    },
    'nbhpres0': {
      'en': 'Old location',
      'th': 'พิกัดเก่า',
      'vi': 'Tọa độ cũ',
    },
    'dh5tylyg': {
      'en': 'New location',
      'th': 'พิกัดใหม่',
      'vi': 'Tọa độ mới',
    },
    '68dxb7jg': {
      'en': 'บันทึก',
      'th': '',
      'vi': 'Lưu',
    },
    'ud7qpnr0': {
      'en': 'Change Lat,Lng',
      'th': '',
      'vi': 'Thay đổi Lat, Lng',
    },
    '2j9o1nc7': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // MyProfilePage
  {
    '7c59mcgf': {
      'en': 'Employee Handbook',
      'th': 'คู่มือพนักงาน',
      'vi': 'Sổ tay nhân viên',
    },
    'ubz6qsvt': {
      'en': 'Profile',
      'th': 'Profile',
      'vi': 'Hồ sơ',
    },
  },
  // GuideBookPage
  {
    'hc3lnn2n': {
      'en': 'Employee Handbook',
      'th': 'คู่มือพนักงาน',
      'vi': 'Sổ tay nhân viên',
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
      'en': 'Success!',
      'th': 'ความสำเร็จ!',
      'vi': 'Thành công!',
    },
    'dm3qluv6': {
      'en': 'Checkin Successful',
      'th': 'เช็คอินสำเร็จ',
      'vi': 'Đã đăng ký thành công',
    },
    '0p889zk0': {
      'en': 'Return to Dashboard',
      'th': 'กลับไปยังแดชบอร์ด',
      'vi': 'Quay lại Bảng điều khiển',
    },
    'ep6jzjsj': {
      'en': 'Check Statue',
      'th': 'ตรวจสอบรูปปั้น',
      'vi': 'Kiểm tra Tượng',
    },
    'b14q64lh': {
      'en': 'Home',
      'th': 'บ้าน',
      'vi': 'Trang chủ',
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
    'lwgr5i7x': {
      'en': 'print date',
      'th': '',
      'vi': '',
    },
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
    'chvvrzbn': {
      'en': 'ชื่อ',
      'th': '',
      'vi': '',
    },
    '5emha11a': {
      'en': 'id',
      'th': '',
      'vi': '',
    },
    'npsbmg9b': {
      'en': 'ทั้งหมด',
      'th': '',
      'vi': '',
    },
    '4u3uk24q': {
      'en': 'เหลือ',
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
      'en': 'Type Keyword',
      'th': 'ประเภทคำสำคัญ',
      'vi': 'Loại từ khóa',
    },
    'wuqoiaft': {
      'en': 'Search',
      'th': 'ค้นหา',
      'vi': 'Tìm kiếm',
    },
    'gztk5uiq': {
      'en': 'Please enter at least 3 characters in your search keyword',
      'th': 'กรุณากรอกคำค้นหาอย่างน้อย 3 ตัวอักษร',
      'vi': 'Vui lòng nhập ít nhất 3 ký tự vào từ khóa tìm kiếm của bạn',
    },
    'l8tbvzm7': {
      'en': 'Search Branch',
      'th': 'ค้นหาสาขา',
      'vi': 'Tìm kiếm chi nhánh',
    },
    'o31gdg36': {
      'en': 'Home',
      'th': 'บ้าน',
      'vi': 'Trang chủ',
    },
  },
  // testCalendar
  {
    'p284fx26': {
      'en': 'calendar',
      'th': '',
      'vi': '',
    },
    'zp5mlaak': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // CancelPage
  {
    'q5k9ngwl': {
      'en': 'ยืนยันยกเลิกการลา',
      'th': '',
      'vi': '',
    },
    'e1jg2oz0': {
      'en': 'ระบุเหตุผล...',
      'th': '',
      'vi': '',
    },
    '3r8ie4m2': {
      'en': 'ตกลง',
      'th': '',
      'vi': '',
    },
    'oj5qzq3a': {
      'en': 'ยกเลิก',
      'th': '',
      'vi': '',
    },
    'obkfjorb': {
      'en': 'ยกเลิกการลา',
      'th': '',
      'vi': '',
    },
    '7uxb0u59': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // ConfirmEmailPage
  {
    '8m06dlb4': {
      'en': 'กรุณากรอก Email ที่ต้องการรับข้อมูล',
      'th': '',
      'vi': '',
    },
    'ulf75id4': {
      'en': 'ระบุ Email',
      'th': '',
      'vi': '',
    },
    'uc1mk3r9': {
      'en': 'ตกลง',
      'th': '',
      'vi': '',
    },
    'ah880bci': {
      'en': 'ยกเลิก',
      'th': '',
      'vi': '',
    },
    'raqolgop': {
      'en': 'ยืนยัน Email',
      'th': '',
      'vi': '',
    },
    'ssa9mvcl': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // ApprovedLeavePage
  {
    'npr1uom5': {
      'en': 'Approve many people',
      'th': 'อนุมัติหลายคน',
      'vi': '',
    },
    'iay7wijr': {
      'en': 'Select all',
      'th': 'เลือกทั้งหมด',
      'vi': '',
    },
    '8v1skjen': {
      'en': 'Approve selected',
      'th': 'อนุมัติที่เลือก',
      'vi': '',
    },
    '9gtffiey': {
      'en': 'Cancel',
      'th': 'ยกเลิก',
      'vi': '',
    },
    'ouxi7r2w': {
      'en': 'Status:',
      'th': 'สถานะ:',
      'vi': '',
    },
    'k5srt8i3': {
      'en': 'Nickname:',
      'th': 'ชื่อเล่น:',
      'vi': '',
    },
    'b3bahwxv': {
      'en': 'Department affiliation:',
      'th': 'สังกัดแผนก:',
      'vi': '',
    },
    'g3lsp65w': {
      'en': '[รอดำเนินการ]',
      'th': '[รอดำเนินการ]',
      'vi': '',
    },
    'w0nvlwg7': {
      'en': 'Type of leave:',
      'th': 'ประเภทการลา:',
      'vi': '',
    },
    'gng922zv': {
      'en': 'Transaction date:',
      'th': 'วันที่ทำรายการ:',
      'vi': '',
    },
    '0ujmyhz5': {
      'en': 'Leave date:',
      'th': 'วันที่ลา:',
      'vi': '',
    },
    '0gdw90ug': {
      'en': 'Number of leave days:',
      'th': 'จำนวนวันที่ลา:',
      'vi': '',
    },
    'fpgss961': {
      'en': 'Time period:',
      'th': 'ช่วงเวลา:',
      'vi': '',
    },
    'g74iy68d': {
      'en': 'Reason for leave:',
      'th': 'เหตุผลการลา:',
      'vi': '',
    },
    'fdr09igk': {
      'en': 'Contact telephone number:',
      'th': 'เบอร์ติดต่อ:',
      'vi': '',
    },
    '1g9vmjum': {
      'en': 'Attachment:',
      'th': 'ไฟล์เเนบ:',
      'vi': '',
    },
    'cxtkyf9c': {
      'en': 'Approve',
      'th': 'อนุมัติ',
      'vi': '',
    },
    'efs1tfam': {
      'en': 'Do not approve',
      'th': 'ไม่อนุมัติ',
      'vi': '',
    },
    'v5174jja': {
      'en': 'Leave approval list',
      'th': 'รายการอนุมัติลา',
      'vi': '',
    },
    '29x4izzy': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // ApproveShowPage
  {
    'yaf5hk1f': {
      'en': 'Please select the month you want to search for',
      'th': 'กรุณาเลือกเดือนที่ต้องการหา',
      'vi': '',
    },
    'ci20ou7l': {
      'en': 'มกราคม',
      'th': '',
      'vi': '',
    },
    'ub583bqh': {
      'en': 'กุมภาพันธ์',
      'th': '',
      'vi': '',
    },
    'o8jvanhe': {
      'en': 'มีนาคม',
      'th': '',
      'vi': '',
    },
    'gvs5s7c8': {
      'en': 'เมษายน',
      'th': '',
      'vi': '',
    },
    'f4x7k16x': {
      'en': 'พฤษภาคม',
      'th': '',
      'vi': '',
    },
    '25i0nsss': {
      'en': 'มิถุนายน',
      'th': '',
      'vi': '',
    },
    'w3jv3kct': {
      'en': 'กรกฎาคม',
      'th': '',
      'vi': '',
    },
    'byf99dzy': {
      'en': 'สิงหาคม',
      'th': '',
      'vi': '',
    },
    'oosfavsl': {
      'en': 'กันยายน',
      'th': '',
      'vi': '',
    },
    'jqss06f9': {
      'en': 'ตุลาคม',
      'th': '',
      'vi': '',
    },
    'l2fp2qht': {
      'en': 'พฤศจิกายน',
      'th': '',
      'vi': '',
    },
    'ioa5adoz': {
      'en': 'ธันวาคม',
      'th': '',
      'vi': '',
    },
    'zog3trpj': {
      'en': 'Approve',
      'th': 'อนุมัติ',
      'vi': '',
    },
    'ry9t5l7w': {
      'en': 'นางสาวมนฑิรา ยอดแสง',
      'th': '',
      'vi': '',
    },
    'wu7bwqpo': {
      'en': 'Type of leave:',
      'th': 'ประเภทการลา:',
      'vi': '',
    },
    'n98opwaw': {
      'en': '[ลากิจ]',
      'th': '[ลากิจ]',
      'vi': '',
    },
    'nzyrvgfg': {
      'en': 'Transaction date:',
      'th': 'วันที่ทำรายการ:',
      'vi': '',
    },
    '5e8fdojn': {
      'en': '[01/11/2565]',
      'th': '[01/11/2565]',
      'vi': '',
    },
    '6si6wxv9': {
      'en': 'Leave date:',
      'th': 'วันที่ลา:',
      'vi': '',
    },
    '4jpfh0kl': {
      'en': '[11/11/2565-12/11/2565]',
      'th': '[11/11/2565-12/11/2565]',
      'vi': '',
    },
    'f92owody': {
      'en': 'Number of leave days:',
      'th': 'จำนวนวันที่ลา:',
      'vi': '',
    },
    'fmtdk2hj': {
      'en': '[2]',
      'th': '',
      'vi': '',
    },
    '68jor54s': {
      'en': 'Time period:',
      'th': 'ช่วงเวลา:',
      'vi': '',
    },
    'f0d8msx4': {
      'en': '[ลาเต็มวัน]',
      'th': '',
      'vi': '',
    },
    'fboxmgh9': {
      'en': 'Reason for leave:',
      'th': 'เหตุผลการลา:',
      'vi': '',
    },
    '7ecl265k': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    'vecl8vum': {
      'en': 'Cancel',
      'th': 'ยกเลิก',
      'vi': '',
    },
    'ju9gujxi': {
      'en': 'Not approved',
      'th': 'ไม่อนุมัติ',
      'vi': '',
    },
    '17h2yfm5': {
      'en': 'นางสาวมนฑิรา ยอดแสง',
      'th': '',
      'vi': '',
    },
    '8t704b06': {
      'en': 'Type of leave:',
      'th': 'ประเภทการลา:',
      'vi': '',
    },
    '6lqnvew1': {
      'en': '[ลากิจ]',
      'th': '',
      'vi': '',
    },
    'ys1edxki': {
      'en': 'Transaction date:',
      'th': 'วันที่ทำรายการ:',
      'vi': '',
    },
    'sfcwclje': {
      'en': '[01/11/2565]',
      'th': '',
      'vi': '',
    },
    '7fjre75u': {
      'en': 'Leave date:',
      'th': 'วันที่ลา:',
      'vi': '',
    },
    '1rknhkyu': {
      'en': '[11/11/2565-12/11/2565]',
      'th': '',
      'vi': '',
    },
    'sucyvupt': {
      'en': 'Number of leave days:',
      'th': 'จำนวนวันที่ลา:',
      'vi': '',
    },
    'yrwpaktz': {
      'en': '[2]',
      'th': '',
      'vi': '',
    },
    'btjotui7': {
      'en': 'Time period:',
      'th': 'ช่วงเวลา:',
      'vi': '',
    },
    'lhyym0me': {
      'en': '[ลาเต็มวัน]',
      'th': '',
      'vi': '',
    },
    'h9xs8tj1': {
      'en': 'Reason for leave:',
      'th': 'เหตุผลการลา:',
      'vi': '',
    },
    'ftuagybp': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    'bbrf4wkp': {
      'en': 'Cancel',
      'th': 'ยกเลิก',
      'vi': '',
    },
    'yj8ercyv': {
      'en': 'นางสาวมนฑิรา ยอดแสง',
      'th': '',
      'vi': '',
    },
    '9rn3l90n': {
      'en': 'Type of leave:',
      'th': 'ประเภทการลา:',
      'vi': '',
    },
    '6x27g592': {
      'en': '[ลากิจ]',
      'th': '',
      'vi': '',
    },
    'm5y8iz1t': {
      'en': 'Transaction date:',
      'th': 'วันที่ทำรายการ:',
      'vi': '',
    },
    'r8hn4bdz': {
      'en': '[01/11/2565]',
      'th': '',
      'vi': '',
    },
    'mkio0twd': {
      'en': 'Leave date:',
      'th': 'วันที่ลา:',
      'vi': '',
    },
    '2h9up40u': {
      'en': '[11/11/2565-12/11/2565]',
      'th': '',
      'vi': '',
    },
    '6s0ra4ev': {
      'en': 'Number of leave days:',
      'th': 'จำนวนวันที่ลา:',
      'vi': '',
    },
    'kbi81yuc': {
      'en': '[2]',
      'th': '',
      'vi': '',
    },
    'yvyhvbem': {
      'en': 'Time period:',
      'th': 'ช่วงเวลา:',
      'vi': '',
    },
    'toaf452f': {
      'en': '[ลาเต็มวัน]',
      'th': '',
      'vi': '',
    },
    'wsbsizda': {
      'en': 'Reason for leave:',
      'th': 'เหตุผลการลา:',
      'vi': '',
    },
    '04brg3y6': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    'fou3q3o0': {
      'en': 'Canceled by:',
      'th': 'ถูกยกเลิกโดย:',
      'vi': '',
    },
    'gjzr33yv': {
      'en': '[]',
      'th': '',
      'vi': '',
    },
    'c1mkkoeu': {
      'en': 'List',
      'th': 'รายการ',
      'vi': '',
    },
    'ln348tdv': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // AddResignPage
  {
    '1p6xvu7s': {
      'en': '[Some hint text...]',
      'th': '',
      'vi': '',
    },
    '14ilm5iv': {
      'en': 'ประเภทการลา: ลาออก',
      'th': '',
      'vi': '',
    },
    'b04k4nfv': {
      'en': 'วันที่ทำงานวันสุดท้าย  :',
      'th': '',
      'vi': '',
    },
    '9rswm622': {
      'en': 'ระบุวันที่',
      'th': '',
      'vi': '',
    },
    'ojtl5sgg': {
      'en': 'เหตุผลที่ตัดสินใจลาออก (ระบุได้มากกว่า 1 ข้อ)  :',
      'th': '',
      'vi': '',
    },
    'sgjkyk5p': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    'xqwwlx2j': {
      'en': 'อื่นๆ  :',
      'th': '',
      'vi': '',
    },
    'xgafgfqt': {
      'en': 'ระบุ...',
      'th': '',
      'vi': '',
    },
    '5dois0z1': {
      'en': 'อยากให้บริษัทปรับปรุงการทำงานด้านใดบ้าง  :',
      'th': '',
      'vi': '',
    },
    '5s6i0679': {
      'en': 'กรุณากรอก...',
      'th': '',
      'vi': '',
    },
    '8hqyjbe0': {
      'en': 'ในช่วงที่แจ้งลาออก สามารถติดต่อได้ที่ :',
      'th': '',
      'vi': '',
    },
    'vruwucvp': {
      'en': 'กรุณาเลือกจังหวัด...',
      'th': '',
      'vi': '',
    },
    '6smmdirl': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    'jn23m6pt': {
      'en': 'กรุณาเลือกอำเภอ...',
      'th': '',
      'vi': '',
    },
    'af2rga2h': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    '9dgpo4iy': {
      'en': 'กรุณาเลือกตำบล...',
      'th': '',
      'vi': '',
    },
    'o6nytm6z': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    'pei96fxr': {
      'en': 'กรุณาเลือกรหัสไปรษณีย์...',
      'th': '',
      'vi': '',
    },
    'fqawe8q3': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    '7soisp68': {
      'en': 'ระบุหมู่ที่/ถนน',
      'th': '',
      'vi': '',
    },
    'uaigiro9': {
      'en': 'เบอร์ติดต่อ',
      'th': '',
      'vi': '',
    },
    'hlwgphwz': {
      'en': 'หากมีโอกาสจะกลับมาร่วมงานกับบริษัทหรือไม่  :',
      'th': '',
      'vi': '',
    },
    '6tzsbxm9': {
      'en': 'กรุณาเลือก...',
      'th': '',
      'vi': '',
    },
    '20h6md13': {
      'en': 'ร่วมงาน',
      'th': '',
      'vi': '',
    },
    'untfjje1': {
      'en': 'ไม่ร่วมงาน',
      'th': '',
      'vi': '',
    },
    '4o4btaer': {
      'en': 'ทรัพย์สินของบริษัทที่ต้องส่งคืน (ระบุได้มากกว่า 1 ข้อ)  :',
      'th': '',
      'vi': '',
    },
    'haztp0ir': {
      'en': 'Option 1',
      'th': '',
      'vi': '',
    },
    'z65ahjr3': {
      'en': 'อื่นๆ  :',
      'th': '',
      'vi': '',
    },
    'atq6169s': {
      'en': 'ระบุ...',
      'th': '',
      'vi': '',
    },
    '2s9h0bsb': {
      'en': 'บันทึก',
      'th': '',
      'vi': '',
    },
    'ui4tf8f1': {
      'en': 'ยื่นเรื่องขออนุมัติลาออก',
      'th': '',
      'vi': '',
    },
    'z5xufqr2': {
      'en': 'Home',
      'th': 'Profile',
      'vi': 'Profile',
    },
  },
  // formServicePage
  {
    '70n0shev': {
      'en': 'Home',
      'th': '',
      'vi': '',
    },
  },
  // CalendarPage
  {
    'sxfn8fc6': {
      'en': 'print date',
      'th': '',
      'vi': '',
    },
    'ddp4swob': {
      'en': 'ตกลง',
      'th': '',
      'vi': '',
    },
    '3s9c8puw': {
      'en': 'เลือกวันที่ต้องการลา',
      'th': '',
      'vi': '',
    },
    '09m5bpo0': {
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
      'th': 'สถานะทั้งหมด',
      'vi': 'Tất cả trạng thái',
    },
    'mqn06a20': {
      'en': 'เช็คอินเข้า-ออกงาน จะมีเเถบเเละสถานะดังนี้',
      'th': 'เช็คอินเข้า-ออกงาน จะมีเเถบเเละสถานะดังนี้',
      'vi': 'Khi chấm công vào/ra làm việc, sẽ có các trạng thái sau:',
    },
    'kh7en1yk': {
      'en': 'วันหยุดเเละวันหยุดตามประเพณี',
      'th': 'วันหยุดเเละวันหยุดตามประเพณี',
      'vi': 'Ngày nghỉ và ngày nghỉ lễ theo truyền thống',
    },
    '0il619bg': {
      'en': 'ขาดงาน',
      'th': 'ขาดงาน',
      'vi': 'Nghỉ làm không phép',
    },
    '3py39tbc': {
      'en': 'ลงเวลาไม่ครบ(ไม่เช็คเอาท์ออกงาน)',
      'th': 'ลงเวลาไม่ครบ(ไม่เช็คเอาท์ออกงาน)',
      'vi': 'Ghi nhận thời gian không đầy đủ (không chấm công ra)',
    },
    'q4nj7lx7': {
      'en': 'เข้างานไม่ครบจำนวน(ทำงานไม่ครบ 8 ชั่วโมง)',
      'th': 'เข้างานไม่ครบจำนวน(ทำงานไม่ครบ 8 ชั่วโมง)',
      'vi': 'Thời gian làm việc không đủ (làm việc không đủ 8 giờ)',
    },
    '0g6rkfn2': {
      'en': 'สาย (เช็คอินหลังเวลาเข้างาน)',
      'th': 'สาย (เช็คอินหลังเวลาเข้างาน)',
      'vi': 'Đi muộn (chấm công vào sau giờ làm việc)',
    },
    'fn4vqph9': {
      'en': 'ออกก่อนเวลา (เช็คเอาท์ก่อนเวลาเลิกงาน)',
      'th': 'ออกก่อนเวลา (เช็คเอาท์ก่อนเวลาเลิกงาน)',
      'vi': 'Về sớm (chấm công ra trước giờ tan ca)',
    },
    '5qzqlkly': {
      'en': 'ปกติ',
      'th': 'ปกติ',
      'vi': 'Bình thường',
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
      'en': 'Type Keyword',
      'th': 'ประเภทคำสำคัญ',
      'vi': 'Loại từ khóa',
    },
  },
  // serchBranchComponentCheckin
  {
    'la9fs10d': {
      'en': 'Type Branch Name',
      'th': 'พิมพ์ชื่อสาขา',
      'vi': 'Loại Tên Chi Nhánh',
    },
  },
  // addBranchLo
  {
    '0sedvpht': {
      'en': 'Add Branch',
      'th': 'เพิ่มสาขา',
      'vi': 'Thêm nhánh',
    },
    'qmpuw8u9': {
      'en': 'Branch Code',
      'th': 'รหัสสาขา',
      'vi': 'Mã chi nhánh',
    },
    'yljhs3rr': {
      'en': 'Latitude',
      'th': 'ละติจูด',
      'vi': 'Vĩ độ',
    },
    'mw8ii5r1': {
      'en': 'Longitude',
      'th': 'ลองจิจูด',
      'vi': 'Kinh độ',
    },
    'mtq2moqx': {
      'en': 'Branch Name',
      'th': 'ชื่อสาขา',
      'vi': 'Tên chi nhánh',
    },
    '4j9zgrfq': {
      'en': 'Type Branch Name',
      'th': 'พิมพ์ชื่อสาขา',
      'vi': 'Loại Tên Chi Nhánh',
    },
    'mk9hibp1': {
      'en': 'Area Code',
      'th': 'รหัสพื้นที่',
      'vi': 'Mã khu vực',
    },
    '51gtgp4l': {
      'en': 'Type Area Code',
      'th': 'ประเภท รหัสพื้นที่',
      'vi': 'Mã vùng loại',
    },
    'zhfgoeeu': {
      'en': '',
      'th': '',
      'vi': '',
    },
    '6k592bd8': {
      'en': 'Region Code',
      'th': 'รหัสภูมิภาค',
      'vi': 'Mã vùng',
    },
    '8osenk5v': {
      'en': 'Type Region Code',
      'th': 'ประเภทรหัสภูมิภาค',
      'vi': 'Loại Mã vùng',
    },
    'po0mmgz2': {
      'en': 'Add Branch',
      'th': 'เพิ่มสาขา',
      'vi': 'Thêm nhánh',
    },
  },
  // SelectLanguageComponent
  {
    'z9wupsex': {
      'en': 'Select Language',
      'th': 'เลือกภาษา',
      'vi': 'Chọn Ngôn Ngữ',
    },
    'hk2e1qgf': {
      'en': 'Select...',
      'th': 'เลือก...',
      'vi': 'Lựa chọn...',
    },
    'gro3nnlg': {
      'en': 'Search...',
      'th': 'Search...',
      'vi': 'Tìm kiếm...',
    },
    'sq3inuds': {
      'en': 'English',
      'th': 'ภาษาอังกฤษ',
      'vi': 'Tiếng Anh',
    },
    'iibe6wmu': {
      'en': 'Veitnamese',
      'th': 'ภาษาเวียดนาม',
      'vi': 'Việt Nam',
    },
    '1scoi5ff': {
      'en': 'ไทย',
      'th': 'ภาษาไทย',
      'vi': 'Thái Lan',
    },
    'l1cgvu45': {
      'en': 'Apply',
      'th': 'เลือกภาษา',
      'vi': 'Áp dụng',
    },
  },
  // ConfirmCancelLeaveComponent
  {
    '3fsz4nym': {
      'en': 'ยืนยันยกเลิกการลา',
      'th': 'ยืนยันยกเลิกการลา',
      'vi': 'ยืนยันยกเลิกการลา',
    },
    '6b6wmwup': {
      'en': 'ระบุเหตุผล...',
      'th': 'ระบุเหตุผล...',
      'vi': 'ระบุเหตุผล...',
    },
    'md2xelp4': {
      'en': 'ยกเลิก',
      'th': 'ยกเลิก',
      'vi': 'ยกเลิก',
    },
    'm27y9t0n': {
      'en': 'ตกลง',
      'th': 'ตกลง',
      'vi': 'ตกลง',
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
