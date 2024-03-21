part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class GetDataFromField extends RegisterEvent {
  final String thaiId;
  final String phoneNumber;
  final String firstname;
  final String lastname;
  final String dob;
  final String address;
  final String province;
  final String district;
  final String subdistrict;
  final String poscode;
  final String email;
  final String lineid;
  late bool isValidated;

  GetDataFromField(
      this.thaiId,
      this.phoneNumber,
      this.firstname,
      this.lastname,
      this.dob,
      this.address,
      this.province,
      this.district,
      this.subdistrict,
      this.poscode,
      this.email,
      this.lineid,
      this.isValidated);
}
