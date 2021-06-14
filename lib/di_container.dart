import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/transactions/data/datasources/preferences_data_source.dart';
import 'features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'features/transactions/data/repositories/preferences_repository_impl.dart';
import 'features/transactions/data/repositories/transaction_repository_impl.dart';
import 'features/transactions/domain/repositories/preferences_repository.dart';
import 'features/transactions/domain/repositories/transaction_repository.dart';
import 'features/transactions/domain/usecases/get_date_range.dart';
import 'features/transactions/domain/usecases/get_transactions.dart';
import 'features/transactions/domain/usecases/set_date_range.dart';
import 'features/transactions/presentation/bloc/date_range_cubit/date_range_cubit.dart';
import 'features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<TransactionsListCubit>(
    () {
      return TransactionsListCubit(
        getTransactionsFunc: sl(),
      );
    },
  );

  sl.registerFactory<DateRangeCubit>(
    () {
      return DateRangeCubit(
        setDataRange: sl(),
        getDateRange: sl(),
      );
    },
  );

  // Use cases
  sl.registerLazySingleton(() => GetTransactions(
      preferencesRepository: sl(), transactionRepository: sl()));

  sl.registerLazySingleton(() => SetDateRange(preferencesRepository: sl()));
  sl.registerLazySingleton(() => GetDateRange(preferencesRepository: sl()));

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<PreferencesRepository>(
    () => PreferencesRepositoryImpl(
      preferencesDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<PreferencesDataSource>(
    () => PreferencesDataSourceImpl(preferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
