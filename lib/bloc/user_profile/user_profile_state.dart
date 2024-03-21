part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  late UserProfileData userProfileData;
  late Uint8List imageFile;
  UserProfileState({required this.userProfileData, required this.imageFile});

  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {
  // final UserProfileData userProfileData;
  UserProfileInitial(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileLoading extends UserProfileState {
  UserProfileLoading(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileComplete extends UserProfileState {
  UserProfileComplete(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileImageLoading extends UserProfileState {
  UserProfileImageLoading(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileImageComplete extends UserProfileState {
  UserProfileImageComplete(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileAftercomplete extends UserProfileState {
  UserProfileAftercomplete(
      {required super.userProfileData, required super.imageFile});
}

class UserProfilePhotoLoading extends UserProfileState {
  UserProfilePhotoLoading(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileUpdatePhotoComplete extends UserProfileState {
  UserProfileUpdatePhotoComplete(
      {required super.userProfileData, required super.imageFile});
}

class UserProfileError extends UserProfileState {
  UserProfileError({required super.userProfileData, required super.imageFile});
}
