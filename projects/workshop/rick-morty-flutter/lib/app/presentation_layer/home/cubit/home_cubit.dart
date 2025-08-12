import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/app/infra/infra.dart';

import '../../../domain_layer/domain_layer.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeCharactersUseCase _getHomeCharactersUseCase;
  final GetHomeCharacterByIdUseCase _getHomeCharacterByIdUseCase;

  HomeCubit(
    this._getHomeCharactersUseCase,
    this._getHomeCharacterByIdUseCase,
  ) : super(const HomeState());

  Future<void> fetch({
    required int page,
    String? name,
    String? status,
    bool append = false,
  }) async {
    if (!append) {
      emit(state.copyWith(
        state: const LoadingState(),
        isLoadingMore: false,
      ));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      final data = await _getHomeCharactersUseCase(
        page: page,
        name: name,
        status: status,
      );

      final merged =
          append ? [...state.characters, ...data.results] : data.results;

      emit(state.copyWith(
        state: const SuccessState(),
        characters: merged,
        info: data.info,
        currentPage: page,
        isLoadingMore: false,
      ));
    } on DataFailure catch (e) {
      emit(state.copyWith(
        state: FailureState(e.message),
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: FailureState('Erro inesperado: $e'),
        isLoadingMore: false,
      ));
    }
  }

  Future<void> getCharacterById(int id) async {
    emit(state.copyWith(state: const LoadingState()));
    try {
      await _getHomeCharacterByIdUseCase(id: id);
      emit(state.copyWith(state: const SuccessState()));
    } on DataFailure catch (e) {
      emit(state.copyWith(state: FailureState(e.message)));
    } catch (e) {
      emit(state.copyWith(state: FailureState('Erro inesperado: $e')));
    }
  }
}
