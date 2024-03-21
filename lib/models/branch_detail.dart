import '../util/check_string_format.dart';

class BranchDetail {
  String branchId;
  String branchShortName;
  String branchName;
  String branchEmail;
  String brnachAddress;
  String subDistrict;
  String district;
  String province;
  String postNumber;
  String mobilePhoneNumber;
  String phoneNumber;
  String latitude;
  String longtitude;
  String hashLocation;
  double? distance;

  BranchDetail({
    required this.branchId,
    required this.branchShortName,
    required this.branchName,
    required this.branchEmail,
    required this.brnachAddress,
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.postNumber,
    required this.mobilePhoneNumber,
    required this.phoneNumber,
    required this.latitude,
    required this.longtitude,
    required this.hashLocation,
  });

  factory BranchDetail.fromJson(Map<String, dynamic> json) {
    return BranchDetail(
      branchId: json['branch_id'],
      branchShortName: json['branch_initials'],
      branchName: json['branch_name'],
      branchEmail: json['email'],
      brnachAddress: filterAddress(json['address_details'].toString()),
      subDistrict: json['address_sub_district'],
      district: json['address_district'],
      province: json['address_province'],
      postNumber: json['address_postal_code'],
      mobilePhoneNumber: json['phone_number'],
      phoneNumber: json['branch_phone_number'],
      latitude: json['Latitude'],
      longtitude: json['Longtitude'],
      hashLocation: json['hashLocation'],
    );
  }
}
