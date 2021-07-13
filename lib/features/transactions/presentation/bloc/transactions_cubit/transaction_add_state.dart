import '../../../../../core/bloc/base_state.dart';

class TransactionFillState extends BaseState {
  final String deparmentId;
  final String deparmentName;
  final String sourceId;
  final String sourceName;
  final String employeeId;
  final String employeeName;
  final String employeeType;
  final int paymentType;

  TransactionFillState(
      {this.deparmentId = '',
      this.deparmentName = '',
      this.sourceId = '',
      this.sourceName = '',
      this.paymentType = 0,
      this.employeeType = '',
      this.employeeId = '',
      this.employeeName = ''});

  TransactionFillState copyWith(
      {String? deparmentId,
      String? deparmentName,
      String? sourceId,
      String? sourceName,
      int? paymentType,
      String? employeeType,
      String? employeeId,
      String? employeeName}) {
    return TransactionFillState(
        deparmentId: deparmentId ?? this.deparmentId,
        deparmentName: deparmentName ?? this.deparmentName,
        sourceId: sourceId ?? this.sourceId,
        sourceName: sourceName ?? this.sourceName,
        paymentType: paymentType ?? this.paymentType,
        employeeType: employeeType ?? this.employeeType,
        employeeId: employeeId ?? this.employeeId,
        employeeName: employeeName ?? this.employeeName);
  }

  @override
  List<Object> get props => [
        deparmentId,
        deparmentName,
        sourceId,
        sourceName,
        paymentType,
        employeeType,
        employeeId,
        employeeName
      ];
}
