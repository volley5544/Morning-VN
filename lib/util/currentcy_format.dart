import 'package:intl/intl.dart' as intl;

String convertCurrentcy(int amount) {
  try {
    final oCcy = new intl.NumberFormat("#,##0.00", "en_US");

    return oCcy.format(amount);
  } catch (e) {
    return '0.00';
  }
}

String convertDoubleCurrentcy(double amount) {
  try {
    final oCcy = intl.NumberFormat.simpleCurrency(locale: 'th_TH', name: '');

    return oCcy.format(amount);
  } catch (e) {
    return '0.00';
  }
}

String convertDoubleCurrentcyNoDecimal(double amount) {
  try {
    final oCcy = intl.NumberFormat.simpleCurrency(
        locale: 'th_TH', name: '', decimalDigits: 0);

    return oCcy.format(amount);
  } catch (e) {
    return '0.00';
  }
}

int parIntSafty(String value) {
  try {
    return int.parse(value);
  } catch (e) {
    return 0;
  }
}

double parDoubleSafty(String value) {
  try {
    return double.parse(value);
  } catch (e) {
    return 0;
  }
}
