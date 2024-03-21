class UserProfileData {
  // String status = '';
  String code = '';
  String message = '';
  bool isExistingCustomer = false;
  String thaiId = '';
  String? title = '';
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String dob = '';
  String? email = '';
  String addressDetails = '';
  String addressSubDistrict = '';
  String addressDistinct = '';
  String addressProvince = '';
  String addressPostalCode = '';
  String? lineId = '';
  //bool status = false;

  UserProfileData({
    // required this.status,
    required this.code,
    required this.message,
    required this.isExistingCustomer,
    required this.thaiId,
    this.title,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dob,
    this.email,
    required this.addressDetails,
    required this.addressSubDistrict,
    required this.addressDistinct,
    required this.addressProvince,
    required this.addressPostalCode,
    this.lineId,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
        code: json['code'] ?? '',
        message: json['message'] ?? '',
        isExistingCustomer: json['is_existing_customer'] ?? false,
        thaiId: json['thai_id'] ?? '',
        title: json['title'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        dob: json['dob'] ?? '',
        email: json['email'] ?? '',
        addressDetails: json['address_details'] ?? '',
        addressSubDistrict: json['address_sub_district'] ?? '',
        addressDistinct: json['address_distinct'] ?? '',
        addressProvince: json['address_province'] ?? '',
        addressPostalCode: json['address_postal_code'] ?? '',
        lineId: json['line_id'] ?? '');
  }
}
