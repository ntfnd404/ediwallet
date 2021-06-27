import '../../../../core/bloc/base_state.dart';

class TransactionFillState extends BaseState {
  final String deparmentId;
  final String deparmentName;
  final String sourceId;
  final String sourceName;
  final int paymentType;

  TransactionFillState(
      {this.deparmentId = '',
      this.deparmentName = '',
      this.sourceId = '',
      this.sourceName = '',
      this.paymentType = 0});

  TransactionFillState copyWith(
      {String? deparmentId,
      String? deparmentName,
      String? sourceId,
      String? sourceName,
      int? paymentType}) {
    return TransactionFillState(
        deparmentId: deparmentId ?? this.deparmentId,
        deparmentName: deparmentName ?? this.deparmentName,
        sourceId: sourceId ?? this.sourceId,
        sourceName: sourceName ?? this.sourceName,
        paymentType: paymentType ?? this.paymentType);
  }

  @override
  List<Object> get props =>
      [deparmentId, deparmentName, sourceId, sourceName, paymentType];
}
