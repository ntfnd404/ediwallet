import 'package:bloc/bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../domain/usecases/add_transaction.dart';
import 'transaction_add_state.dart';

class TransactionsAddCubit extends Cubit<BaseState> {
  final AddTransaction addTransactionsFunc;

  TransactionsAddCubit({required this.addTransactionsFunc})
      : super(InitialState());

  Future<void> inputValueToField(
      {required String field, required String id, required String name}) async {
    if (state is InitialState) {
      switch (field) {
        case 'deparment':
          emit(TransactionFillState(deparmentId: id, deparmentName: name));
          break;
        case 'source':
          emit(TransactionFillState(sourceId: id, sourceName: name));
          break;
        default:
      }
    } else if (state is TransactionFillState) {
      switch (field) {
        case 'deparment':
          emit((state as TransactionFillState)
              .copyWith(deparmentId: id, deparmentName: name));
          break;
        case 'source':
          emit((state as TransactionFillState)
              .copyWith(sourceId: id, sourceName: name));
          break;

        default:
          emit(state);
      }
    }
  }

  Future<void> inputPaymentType({required int paymentType}) async {
    if (state is InitialState) {
      emit(TransactionFillState(paymentType: paymentType));
    } else if (state is TransactionFillState) {
      emit((state as TransactionFillState).copyWith(paymentType: paymentType));
    }
  }

  Future createTransaction(String sum) async {
    if (state is TransactionFillState) {
      // TODO: валидируем поля
      final TransactionFillState newState = state as TransactionFillState;
      await addTransactionsFunc(AddTransactionEntityParams(
          paymentType: newState.paymentType,
          sourceId: newState.sourceId,
          departmentId: newState.deparmentId,
          sum: sum));
    }
  }
}
