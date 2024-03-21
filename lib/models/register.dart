class RegisterVerfiy {
  String? thaiId = '';
  // String? hashThaiId = '';
  String? phoneNumber = '';
  String? firstName = '';
  String? lastName = '';
  String? title = '';
  String? dob = '';
  String? email = '';
  String? addressDetails = '';
  String? addressSubDistrict = '';
  String? addressDistrict = '';
  String? addressProvince = '';
  String? addressPostalCode = '';
  bool isExistingCustomer = false;
  String? lineId = '';
  String? status = '';
  String? code = '';
  String? message = '';

  RegisterVerfiy(
      {this.thaiId,
      // this.hashThaiId,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.title,
      this.dob,
      this.email,
      this.addressDetails,
      this.addressSubDistrict,
      this.addressDistrict,
      this.addressProvince,
      this.addressPostalCode,
      required this.isExistingCustomer,
      this.lineId,
      this.code,
      this.message,
      this.status});

  factory RegisterVerfiy.fromJson(Map<String, dynamic> json) {
    return RegisterVerfiy(
      thaiId: json['thai_id'],
      // hashThaiId: json['hash_thai_id'],
      phoneNumber: json['phone_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      title: json['title'],
      dob: json['dob'],
      email: json['email'],
      addressDetails: json['address_details'],
      addressSubDistrict: json['address_sub_district'],
      addressDistrict: json['address_distinct'],
      addressProvince: json['address_province'],
      addressPostalCode: json['address_postal_code'],
      isExistingCustomer: json['is_existing_customer'],
      lineId: json['line_id'],
      status: json['status'],
      code: json['code'],
      message: json['message']
    );
  }
}
