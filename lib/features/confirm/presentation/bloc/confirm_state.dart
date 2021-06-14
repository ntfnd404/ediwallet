part of 'confirm_cubit.dart';

enum CodeStatus { inProgress, success, error }

class ConfirmState extends Equatable {
  final CodeStatus status;
  final bool timerIsWorcked;
  final String phone;

  const ConfirmState(
      {this.status = CodeStatus.inProgress,
      this.timerIsWorcked = true,
      this.phone = ''});

  @override
  List<Object> get props => [status, timerIsWorcked, phone];
}
