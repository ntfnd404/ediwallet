import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ediwallet/core/bloc/base_state.dart';
import 'package:ediwallet/core/error/failure.dart';
import 'package:ediwallet/features/transactions/domain/usecases/add_transaction.dart';

import 'transaction_add_state.dart';

class TransactionsAddCubit extends Cubit<BaseState> {
  final AddTransaction addTransactionsFunc;

  TransactionsAddCubit({required this.addTransactionsFunc})
      : super(InitialState());

  Future inputValueToField(
      {required String field,
      String? employeeType,
      String? id,
      String? name}) async {
    if (state is InitialState) {
      switch (field) {
        case 'deparment':
          emit(TransactionFillState(
              deparmentId: id!,
              deparmentName: name!,
              employeeType: 'Инженеры'));
          break;
        case 'source':
          emit(TransactionFillState(
              sourceId: id!, sourceName: name!, employeeType: 'Инженеры'));
          break;
        case 'employeeType':
          emit(TransactionFillState(employeeType: employeeType!));
          // switch (employeeType) {
          //   case 'Инженеры':
          //     emit(TransactionFillState(employeeType: 'engeneer'));
          //     break;
          //   case 'Офисные сотрудники':
          //     emit(TransactionFillState(employeeType: 'eployee'));
          //     break;
          //   case 'Расклейщики':
          //     emit(TransactionFillState(employeeType: 'postman'));
          //     break;
          //   default:
          // }
          break;
        default:
          emit(TransactionFillState(employeeType: 'Инженеры'));
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
        case 'employee':
          emit((state as TransactionFillState).copyWith(
              employeeId: id, employeeName: name, employeeType: employeeType));
          break;
        case 'employeeType':
          emit((state as TransactionFillState)
              .copyWith(employeeType: employeeType));
          // switch (employeeType) {
          //   case 'Инженеры':
          //     emit((state as TransactionFillState)
          //         .copyWith(employeeType: 'engeneer'));
          //     break;
          //   case 'Офисные сотрудники':
          //     emit((state as TransactionFillState)
          //         .copyWith(employeeType: 'eployee'));
          //     break;
          //   case 'Расклейщики':
          //     emit((state as TransactionFillState)
          //         .copyWith(employeeType: 'postman'));

          //     break;
          //   default:
          // }

          break;

        default:
          emit(state);
      }
    }
  }

  Future inputPaymentType({required int paymentType}) async {
    if (state is InitialState) {
      emit(TransactionFillState(
          paymentType: paymentType, employeeType: 'Инженеры'));
    } else if (state is TransactionFillState) {
      emit((state as TransactionFillState).copyWith(paymentType: paymentType));
    }
  }

  Future<bool> createTransaction(String sum) async {
    if (state is TransactionFillState) {
      // TODO: валидируем поля
      final TransactionFillState newState = state as TransactionFillState;
      final Either<Failure, void> result = await addTransactionsFunc(
          AddTransactionEntityParams(
              paymentType: newState.paymentType,
              sourceId: newState.sourceId,
              departmentId: newState.deparmentId,
              employeeId: newState.employeeId,
              employeeType: newState.employeeType,
              sum: sum));

      result.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
          return false;
        },
        (_) {},
      );
    }
    return true;
  }
}
