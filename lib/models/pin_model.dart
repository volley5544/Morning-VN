class PinStorage {
  String hashThaiId = '',
      phoneNumber = '',
      pin = '',
      ctTimestamp = '',
      upTimestamp = '';

  PinStorage({
    required this.hashThaiId,
    required this.phoneNumber,
    required this.pin,
    required this.ctTimestamp,
    required this.upTimestamp,
  });

  factory PinStorage.fromJson(Map<String, dynamic> json) {
    return PinStorage(
      hashThaiId: json['hash_thai_id'],
      phoneNumber: json['phone_number'],
      pin: json['pin'],
      ctTimestamp: json['ct_timestamp'],
      upTimestamp: json['up_timestamp'],
    );
  }
}
