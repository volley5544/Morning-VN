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

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

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
  // Miscellaneous
  {
    '80tv2pc9': {
      'en': 'Please allow to access your location to tracking your work',
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
    '8076iu0j': {
      'en': 'This app needs access to location.',
      'th': '',
      'vi': '',
    },
    'dn5k9xog': {
      'en': 'This app needs access to location.',
      'th': '',
      'vi': '',
    },
    '4y7fjq43': {
      'en': 'This app needs access to location.',
      'th': '',
      'vi': '',
    },
    'twyrcshe': {
      'en': 'This app need access to run background',
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
