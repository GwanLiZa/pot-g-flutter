import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/core/domain/entities/pot_entity.dart';
import 'package:pot_g/app/modules/core/domain/repositories/pot_list_repository.dart';

part 'pot_list_bloc.freezed.dart';

@Injectable()
class PotListBloc extends Bloc<PotListEvent, PotListState> {
  final PotListRepository _repository;

  PotListBloc(this._repository) : super(_State()) {
    on<_Search>(_onSearch);
  }

  Future<void> _onSearch(_Search event, Emitter<PotListState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final pots = await _repository.getPotList(date: event.date);
      emit(state.copyWith(pots: pots, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}

@freezed
sealed class PotListEvent with _$PotListEvent {
  const factory PotListEvent.search({DateTime? date}) = _Search;
}

@freezed
sealed class PotListState with _$PotListState {
  const factory PotListState({
    @Default([]) List<PotSummaryEntity> pots,
    @Default(false) bool isLoading,
    String? error,
  }) = _State;
}
