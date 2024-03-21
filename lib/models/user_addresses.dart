class CurrentAddress {
  String addressDetails;
  String addressSubDistrict;
  String addressDistrict;
  String addressProvince;
  String addressPostalCode;
  CurrentAddress({
    required this.addressDetails,
    required this.addressSubDistrict,
    required this.addressDistrict,
    required this.addressProvince,
    required this.addressPostalCode,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) {
    return CurrentAddress(
      addressDetails: json['address_details'],
      addressSubDistrict: json['address_sub_district'],
      addressDistrict: json['address_district'],
      addressProvince: json['address_province'],
      addressPostalCode: json['address_postal_code'],
    );
  }
}

class RegistrationAddress {
  String addressDetails;
  String addressSubDistrict;
  String addressDistrict;
  String addressProvince;
  String addressPostalCode;
  RegistrationAddress({
    required this.addressDetails,
    required this.addressSubDistrict,
    required this.addressDistrict,
    required this.addressProvince,
    required this.addressPostalCode,
  });

  factory RegistrationAddress.fromJson(Map<String, dynamic> json) {
    return RegistrationAddress(
      addressDetails: json['address_details'],
      addressSubDistrict: json['address_sub_district'],
      addressDistrict: json['address_district'],
      addressProvince: json['address_province'],
      addressPostalCode: json['address_postal_code'],
    );
  }
}

class IdCardAddress {
  String addressDetails;
  String addressSubDistrict;
  String addressDistrict;
  String addressProvince;
  String addressPostalCode;
  IdCardAddress({
    required this.addressDetails,
    required this.addressSubDistrict,
    required this.addressDistrict,
    required this.addressProvince,
    required this.addressPostalCode,
  });

  factory IdCardAddress.fromJson(Map<String, dynamic> json) {
    return IdCardAddress(
      addressDetails: json['address_details'],
      addressSubDistrict: json['address_sub_district'],
      addressDistrict: json['address_district'],
      addressProvince: json['address_province'],
      addressPostalCode: json['address_postal_code'],
    );
  }
}

class OtherAddress {
  String addressDetails;
  String addressSubDistrict;
  String addressDistrict;
  String addressProvince;
  String addressPostalCode;
  OtherAddress({
    required this.addressDetails,
    required this.addressSubDistrict,
    required this.addressDistrict,
    required this.addressProvince,
    required this.addressPostalCode,
  });

  factory OtherAddress.fromJson(Map<String, dynamic> json) {
    return OtherAddress(
      addressDetails: json['address_details'],
      addressSubDistrict: json['address_sub_district'],
      addressDistrict: json['address_district'],
      addressProvince: json['address_province'],
      addressPostalCode: json['address_postal_code'],
    );
  }
}

class UserAddresses {
  CurrentAddress currentAddress;
  RegistrationAddress registrationAddress;
  IdCardAddress idCardAddress;
  OtherAddress otherAddress;
  String dataDate;
  UserAddresses({
    required this.currentAddress,
    required this.registrationAddress,
    required this.idCardAddress,
    required this.otherAddress,
    required this.dataDate,
  });

  factory UserAddresses.fromJson(Map<String, dynamic> json) {
    return UserAddresses(
      currentAddress: CurrentAddress.fromJson(json['current_address']),
      registrationAddress:
          RegistrationAddress.fromJson(json['registration_address']),
      idCardAddress: IdCardAddress.fromJson(json['id_card_address']),
      otherAddress: OtherAddress.fromJson(json['other_address']),
      dataDate: json['data_date'],
    );
  }
}
