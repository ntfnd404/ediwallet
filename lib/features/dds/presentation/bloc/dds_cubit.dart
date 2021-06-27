import 'package:bloc/bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_dds.dart';

class DDSCubit extends Cubit<BaseState> {
  final GetDDS getDDSFunc;

  DDSCubit({required this.getDDSFunc}) : super(InitialState());

  Future<void> getDDSItems({bool isRefresh = false}) async {
    if (state is InitialState) {
      emit(LoadingState());
      final _failureOrDDSItems = await getDDSFunc(const DDSParams(page: 0));

      _failureOrDDSItems.fold(
        (failure) {
          failure is InternetConnectionFailure
              ? emit(NoInternetConnectionState())
              : emit(FailureState());
        },
        (_fetchedItems) => emit(ItemsListSuccessState(
            items: _fetchedItems, hasReachedMax: _fetchedItems.length < 30)),
      );

      return;
    }
  }
}
