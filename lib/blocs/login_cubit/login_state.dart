part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String verificationCode;
  final String base64LoginPassword;
  final String error;
  final bool submissionSuccess;

  const LoginState(
      {this.verificationCode = '',
      this.base64LoginPassword = '',
      this.error = '',
      this.submissionSuccess = false});

  @override
  List<Object> get props =>
      [verificationCode, base64LoginPassword, submissionSuccess];
}
