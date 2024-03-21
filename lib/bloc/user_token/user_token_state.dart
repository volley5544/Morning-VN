part of 'user_token_bloc.dart';

abstract class UserTokenState extends Equatable {
  final UserToken userToken;
  final RegisterVerfiy registerVerfiy;
  final String phoneNumber;
  const UserTokenState(this.userToken, this.registerVerfiy, this.phoneNumber);

  @override
  List<Object> get props => [userToken];
}

class UserTokenInitial extends UserTokenState {
  const UserTokenInitial(
    super.userToken,
    super.registerVerfiy,
    super.phoneNumber,
  );
}

class SigninInit extends UserTokenState {
  const SigninInit(super.userToken, super.registerVerfiy, super.phoneNumber);
}

class SignInLoading extends UserTokenState {
  const SignInLoading(super.userToken, super.registerVerfiy, super.phoneNumber);
}

class SignInComplete extends UserTokenState {
  const SignInComplete(
    super.userToken,
    super.registerVerfiy,
    super.phoneNumber,
  );
}

class SignInResetComplete extends UserTokenState {
  const SignInResetComplete(
    super.userToken,
    super.registerVerfiy,
    super.phoneNumber,
  );
}

class SignInError extends UserTokenState {
  const SignInError(super.userToken, super.registerVerfiy, super.phoneNumber);
}

class LoginLoading extends UserTokenState {
  const LoginLoading(super.userToken, super.registerVerfiy, super.phoneNumber);
}

class LoginComplete extends UserTokenState {
  const LoginComplete(super.userToken, super.registerVerfiy, super.phoneNumber);
}

class LoginError extends UserTokenState {
  const LoginError(super.userToken, super.registerVerfiy, super.phoneNumber);
}
