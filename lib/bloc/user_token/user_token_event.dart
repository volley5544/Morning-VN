part of 'user_token_bloc.dart';

abstract class UserTokenEvent extends Equatable {
  const UserTokenEvent();

  @override
  List<Object> get props => [];
}

class updateUserToken extends UserTokenEvent {
  final String token;
  updateUserToken(this.token);
}

class updateFirebaseToken extends UserTokenEvent {
  final String firebaseToken;
  updateFirebaseToken(this.firebaseToken);
}

class ResetSigninProfile extends UserTokenEvent {
  const ResetSigninProfile();
}

class BSignin extends UserTokenEvent {
  final RegisterVerfiy registerVerfiy;
  final String? thaiId;
  final String? phoneNumber;
  final String? first_name;
  final String? last_name;
  final String? title;
  final String? dob;
  final String? email;
  final String? address_details;
  final String? address_sub_district;
  final String? address_district;
  final String? address_province;
  final String? address_postal_code;
  final String? line_id;
  const BSignin(
      {this.thaiId,
      this.phoneNumber,
      this.first_name,
      this.last_name,
      this.title,
      this.dob,
      this.email,
      this.address_details,
      this.address_sub_district,
      this.address_district,
      this.address_province,
      this.address_postal_code,
      this.line_id,
      required this.registerVerfiy});
}

class ResignStage extends UserTokenEvent {
  const ResignStage();
}

class LoginUserToTheSysytem extends UserTokenEvent {
  final String thaiId;
  final String phoneNumber;
  final BuildContext context;
  final UserProfile userProfile;
  const LoginUserToTheSysytem(
      this.thaiId, this.phoneNumber, this.context, this.userProfile);
}
