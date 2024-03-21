part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
  @override
  List<Object> get props => [];
}

class GetUserProFileData extends UserProfileEvent {
  UserProfile userProfile;
  String id;
  BuildContext context;
  GetUserProFileData(this.userProfile, this.id, this.context);
}

class UpdateUserProfile extends UserProfileEvent {
  late String email;
  late String id;
  late String lineId;
  late UserProfile userProfile;
  final BuildContext context;
  UpdateUserProfile(
      {required this.email,
      required this.userProfile,
      required this.lineId,
      required this.id,
      required this.context});
}

class UpdateProfile extends UserProfileEvent {
  late String id;
  late String firstName;
  late String lastName;
  late String phone;
  late String dob;
  late String address;
  late String province;
  late String district;
  late String subdistrict;
  late String postal;
  late UserProfile userProfile;
  final BuildContext context;
  UpdateProfile(
      {required this.id,
      required this.userProfile,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.dob,
      required this.address,
      required this.province,
      required this.district,
      required this.subdistrict,
      required this.postal,
      required this.context});
}

class ResetUserProfile extends UserProfileEvent {
  ResetUserProfile();
}

class SetDisplayImage extends UserProfileEvent {
  UserProfile userProfile;
  String imagePath;
  Uint8List imageFile;
  File? capturedPhoto;
  BuildContext inputContext;
  SetDisplayImage(
      {required this.userProfile,
      required this.imagePath,
      required this.imageFile,
      required this.inputContext,
      this.capturedPhoto});
}

class SetDisplayImageFromHome extends UserProfileEvent {
  UserProfile userProfile;
  String imagePath;
  Uint8List imageFile;
  File? capturedPhoto;
  SetDisplayImageFromHome(
      {required this.userProfile,
      required this.imagePath,
      required this.imageFile,
      this.capturedPhoto});
}
