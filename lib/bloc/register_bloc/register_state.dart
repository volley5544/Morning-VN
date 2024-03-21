part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  final String thaiId;
  final String phoneNumber;
  final String firstname;
  final String lastname;
  String dob;
  final String address;
  final String province;
  final String district;
  final String subdistrict;
  final String poscode;
  final String email;
  final String lineid;
  late bool isValidated;
  RegisterState(
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

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  RegisterInitial(
      super.thaiId,
      super.phoneNumber,
      super.firstname,
      super.lastname,
      super.dob,
      super.address,
      super.province,
      super.district,
      super.subdistrict,
      super.poscode,
      super.email,
      super.lineid,
      super.isValidated);
}

class RegisterLoading extends RegisterState {
  RegisterLoading(
      super.thaiId,
      super.phoneNumber,
      super.firstname,
      super.lastname,
      super.dob,
      super.address,
      super.province,
      super.district,
      super.subdistrict,
      super.poscode,
      super.email,
      super.lineid,
      super.isValidated);
}

class RegisterComplete extends RegisterState {
  RegisterComplete(
      super.thaiId,
      super.phoneNumber,
      super.firstname,
      super.lastname,
      super.dob,
      super.address,
      super.province,
      super.district,
      super.subdistrict,
      super.poscode,
      super.email,
      super.lineid,
      super.isValidated);
}

class RegisterError extends RegisterState {
  RegisterError(
      super.thaiId,
      super.phoneNumber,
      super.firstname,
      super.lastname,
      super.dob,
      super.address,
      super.province,
      super.district,
      super.subdistrict,
      super.poscode,
      super.email,
      super.lineid,
      super.isValidated);
}
