// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
// import 'package:mobile_application_srisawad/models/user_profile_data.dart';
// import 'package:mobile_application_srisawad/modules/userProfile/index.dart'
//     as callUser;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'user_profile_test.mocks.dart';

// late callUser.UserProfile userProfile;
// @GenerateMocks([callUser.UserProfile])
// void main() {
//   late UserProfileData mockUserProfileData = UserProfileData(
//       firstname: 'firstname',
//       lastname: 'lastname',
//       personalPhoneNumber: 'personalPhoneNumber',
//       otherContactInfo: 'otherContactInfo',
//       personalEmail: 'personalEmail',
//       lineId: 'lineId',
//       status: true);

//   late UserProfileBloc userProfileBloc;
//   setUp(() {
//     userProfileBloc = UserProfileBloc();
//   });

//   test('bloc should be calling loading state', () {
//     expect(userProfileBloc.state.runtimeType, UserProfileLoading);
//   });

//   blocTest('Userprofile state is the UserprofileInit bloc',
//       build: () {
//         return userProfileBloc;
//       },
//       act: (UserProfileBloc bloc) {
//         MockUserProfile mockUserProfileaaa = MockUserProfile();
//         when(mockUserProfileaaa.getUserProfile.call())
//             .thenAnswer((realInvocation) async => mockUserProfileData);
//         bloc.add(GetUserProFileData(mockUserProfileaaa));
//       },
//       expect: () => [UserProfileInitial(userProfileData: mockUserProfileData)]);
//   tearDown(() {
//     userProfileBloc.close();
//   });
// }
