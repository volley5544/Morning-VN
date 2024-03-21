class QrCodeDetail {
  String code = '';
  String message = '';
  String dataDate = '';
  String prefix = '';
  String suffix = '';
  String taxId = '';
  String ref1 = '';
  String ref2 = '';
  double amount = 0;
  String fullBarcode = '';

  QrCodeDetail({
    required this.code,
    required this.message,
    required this.dataDate,
    required this.prefix,
    required this.suffix,
    required this.taxId,
    required this.ref1,
    required this.ref2,
    required this.amount,
    required this.fullBarcode,
  });
  factory QrCodeDetail.fromJson(Map<String, dynamic> json) {
    return QrCodeDetail(
      code: json['code'],
      message: json['message'],
      dataDate: json['data_date'],
      prefix: json['prefix'],
      suffix: json['suffix'],
      ref1: json['ref1'],
      ref2: json['ref2'],
      amount: json['amount'].toDouble(),
      fullBarcode: json['full_barcode'],
      taxId: json['tax_id'],
    );
  }
}
