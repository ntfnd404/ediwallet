// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:dartz/dartz.dart';
// import 'package:ediwallet/features/transactions/domain/usecases/get_transactions.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import 'package:ediwallet/features/transactions/domain/repositories/transaction_repository.dart';

// class MockTransactionRepository extends Mock implements TransactionRepository {}

// void main(List<String> args) {
//   // ignore: unused_local_variable
//   GetTransactions usecase;
//   MockTransactionRepository mockTransactionsRepository;

//   setUp(() {
//     mockTransactionsRepository = MockTransactionRepository();
//     usecase =
//         GetTransactions(transactionsRepository: mockTransactionsRepository);
//   });

//   // final tAuthKey = 1;
//   // final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

//   // final tTransaction = Transaction(authKey: tAuthKey);

//   test(
//     'Должен получить транзакции из репозитория',
//     () async {
//       // // arrange
//       // when(mockTransactionsRepository.getAllTransactions(
//       //         authKey: any, startDate: any, endDate: any))
//       //     .thenAnswer((_) async => Right(tNumberTrivia));
//       // // act
//       // final result = await usecase.execute(authKey: tAuthKey);
//       // //assert
//       // expect(result, Right(tNumberTrivia.toString()));
//       // verify(mockTransactionsRepository.getAllTransactions(authKey,
//       //     authKey: authKey, startDate: startDate, endDate: endDate));
//       // verifyNoMoreInteractions(mockTransactionsRepository);
//     },
//   );
// }
