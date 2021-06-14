part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String error;
  final bool submissionSuccess;

  const LoginState({
    this.error = '',
    this.submissionSuccess = false,
  });

  @override
  List<Object> get props => [error, submissionSuccess];
}
