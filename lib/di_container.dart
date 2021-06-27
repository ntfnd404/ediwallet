import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/dds/data/datasources/dds_remote_datasource.dart';
import 'features/dds/data/repositories/dds_repository.dart';
import 'features/dds/domain/repositories/i_dds_repository.dart';
import 'features/dds/domain/usecases/get_dds.dart';
import 'features/dds/presentation/bloc/dds_cubit.dart';
import 'features/deparments/data/datasources/department_remote_datasource.dart';
import 'features/deparments/data/repositories/departments_repository_impl.dart';
import 'features/deparments/domain/repositories/departments_repository.dart';
import 'features/deparments/domain/usecases/get_departments_func.dart';
import 'features/deparments/presentation/bloc/departments_cubit.dart';
import 'features/transactions/data/datasources/preferences_data_source.dart';
import 'features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'features/transactions/data/repositories/preferences_repository_impl.dart';
import 'features/transactions/data/repositories/transaction_repository_impl.dart';
import 'features/transactions/domain/repositories/preferences_repository.dart';
import 'features/transactions/domain/repositories/transaction_repository.dart';
import 'features/transactions/domain/usecases/add_transaction.dart';
import 'features/transactions/domain/usecases/get_date_range.dart';
import 'features/transactions/domain/usecases/get_transactions.dart';
import 'features/transactions/domain/usecases/set_date_range.dart';
import 'features/transactions/presentation/bloc/date_range_cubit/date_range_cubit.dart';
import 'features/transactions/presentation/bloc/transaction_add_cubit.dart';
import 'features/transactions/presentation/bloc/transactions_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<TransactionsListCubit>(
    () {
      return TransactionsListCubit(
        getTransactionsFunc: sl(),
      );
    },
  );

  sl.registerFactory<TransactionsAddCubit>(
    () {
      return TransactionsAddCubit(
        addTransactionsFunc: sl(),
      );
    },
  );

  sl.registerFactory<DDSCubit>(
    () {
      return DDSCubit(
        getDDSFunc: sl(),
      );
    },
  );

  sl.registerFactory<DepartmentsCubit>(
    () {
      return DepartmentsCubit(
        getDepartmentsFunc: sl(),
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
  sl.registerLazySingleton(() => AddTransaction(transactionRepository: sl()));
  sl.registerLazySingleton(() => GetDDS(ddsRepository: sl()));
  sl.registerLazySingleton(() => GetDepartments(departmentsRepository: sl()));
  sl.registerLazySingleton(() => SetDateRange(preferencesRepository: sl()));
  sl.registerLazySingleton(() => GetDateRange(preferencesRepository: sl()));

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IDDSRepository>(
    () => DDSRepository(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<DepartmentsRepository>(
    () => DepartmentsRepositoryImpl(
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
  sl.registerLazySingleton<ITransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<DDSRemoteDataSource>(
    () => DDSRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<DepartmentsRemoteDataSource>(
    () => DepartmentsRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<IPreferencesDataSource>(
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
