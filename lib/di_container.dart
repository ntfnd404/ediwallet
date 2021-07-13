import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/accountancy/presentation/bloc/accountancy_cubit.dart';
import 'features/dds/data/datasources/dds_remote_datasource.dart';
import 'features/dds/data/repositories/dds_repository.dart';
import 'features/dds/domain/repositories/i_dds_repository.dart';
import 'features/dds/domain/usecases/get_dds_uc.dart';
import 'features/dds/presentation/bloc/dds_cubit.dart';
import 'features/departments/data/datasources/department_remote_datasource.dart';
import 'features/departments/data/repositories/departments_repository.dart';
import 'features/departments/domain/repositories/i_departments_repository.dart';
import 'features/departments/domain/usecases/get_departments_uc.dart';
import 'features/departments/presentation/bloc/departments_cubit.dart';
import 'features/employees/data/datasources/employees_remote_datasource.dart';
import 'features/employees/data/repositories/employees_repository.dart';
import 'features/employees/domain/repositories/i_employees_repository.dart';
import 'features/employees/domain/usecases/get_employees_uc.dart';
import 'features/employees/presentation/bloc/employees_cubit.dart';
import 'features/transactions/data/datasources/filters_datasorce.dart';
import 'features/transactions/data/datasources/preferences_data_source.dart';
import 'features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'features/transactions/data/repositories/filters_repository.dart';
import 'features/transactions/data/repositories/preferences_repository.dart';
import 'features/transactions/data/repositories/transaction_repository.dart';
import 'features/transactions/domain/repositories/i_filters_repository.dart';
import 'features/transactions/domain/repositories/i_preferences_repository.dart';
import 'features/transactions/domain/repositories/i_transaction_repository.dart';
import 'features/transactions/domain/usecases/add_transaction.dart';
import 'features/transactions/domain/usecases/get_date_range.dart';
import 'features/transactions/domain/usecases/get_transactions.dart';
import 'features/transactions/domain/usecases/set_date_range.dart';
import 'features/transactions/presentation/bloc/date_range_cubit/date_range_cubit.dart';
import 'features/transactions/presentation/bloc/filters_list_bloc/filters_cubit.dart';
import 'features/transactions/presentation/bloc/transactions_cubit/transaction_add_cubit.dart';
import 'features/transactions/presentation/bloc/transactions_cubit/transactions_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<TransactionsListCubit>(
    () => TransactionsListCubit(
      getTransactionsFunc: sl(),
    ),
  );

  sl.registerFactory<TransactionsAddCubit>(
    () => TransactionsAddCubit(
      addTransactionsFunc: sl(),
    ),
  );

  sl.registerFactory<FiltersCubit>(
    () => FiltersCubit(
      filtersRepository: sl(),
    ),
  );

  sl.registerFactory<DDSCubit>(
    () => DDSCubit(
      getDDSFunc: sl(),
    ),
  );

  sl.registerFactory<DepartmentsCubit>(
    () => DepartmentsCubit(
      getDepartmentsFunc: sl(),
    ),
  );

  sl.registerFactory<EmployeesCubit>(
    () => EmployeesCubit(
      getEmployeesFunc: sl(),
    ),
  );

  sl.registerFactory<DateRangeCubit>(
    () => DateRangeCubit(
      setDataRange: sl(),
      getDateRange: sl(),
    ),
  );

  sl.registerFactory<AccountancyCubit>(
    () => AccountancyCubit(
      getDateRange: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTransactions(
        transactionRepository: sl(),
        filtersRepository: sl(),
        getDateRange: sl(),
      ));
  sl.registerLazySingleton(() => AddTransaction(transactionRepository: sl()));
  sl.registerLazySingleton(() => SetDateRange(preferencesRepository: sl()));
  sl.registerLazySingleton(() => GetDateRange(preferencesRepository: sl()));
  sl.registerLazySingleton(() => GetDDS(ddsRepository: sl()));
  sl.registerLazySingleton(() => GetDepartments(repository: sl()));
  sl.registerLazySingleton(() => GetEmployees(repository: sl()));

  // Repository
  sl.registerLazySingleton<IPreferencesRepository>(
    () => PreferencesRepository(
      preferencesDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ITransactionRepository>(
    () => TransactionRepository(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IDepartmentsRepository>(
    () => DepartmentsRepository(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IDDSRepository>(
    () => DDSRepository(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IEmployeesRepository>(
    () => EmployeesRepository(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IFiltersRepository>(
    () => FiltersRepository(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<IPreferencesDataSource>(
    () => PreferencesDataSourceImpl(preferences: sl()),
  );

  sl.registerLazySingleton<ITransactionRemoteDataSource>(
    () => TransactionRemoteDataSource(client: sl()),
  );

  sl.registerLazySingleton<IFiltersDataSource>(
    () => FiltersDataSource(preferences: sl()),
  );

  sl.registerLazySingleton<IDDSRemoteDataSource>(
    () => DDSRemoteDataSource(client: sl()),
  );

  sl.registerLazySingleton<IEmployeesRemoteDataSource>(
    () => EmployeesRemoteDataSource(client: sl()),
  );

  sl.registerLazySingleton<IDepartmentsRemoteDataSource>(
    () => DepartmentsRemoteDataSource(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
