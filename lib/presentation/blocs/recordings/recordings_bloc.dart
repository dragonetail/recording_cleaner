import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';
import 'package:recording_cleaner/domain/usecases/delete_recordings_usecase.dart';
import 'package:recording_cleaner/domain/usecases/get_recordings_usecase.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_state.dart';

class RecordingsBloc extends Bloc<RecordingsEvent, RecordingsState> {
  final GetRecordingsUseCase getRecordings;
  final DeleteRecordingsUseCase deleteRecordings;
  final RecordingRepository repository;

  RecordingsBloc({
    required this.getRecordings,
    required this.deleteRecordings,
    required this.repository,
  }) : super(RecordingsState.initial()) {
    on<LoadRecordings>(_onLoadRecordings);
    on<DeleteRecordings>(_onDeleteRecordings);
    on<UpdateRecording>(_onUpdateRecording);
    on<SelectAllRecordings>(_onSelectAllRecordings);
    on<ToggleRecordingSelection>(_onToggleRecordingSelection);
    on<ToggleSelectionMode>(_onToggleSelectionMode);
  }

  Future<void> _onLoadRecordings(
    LoadRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final recordings = await getRecordings(
        timeFilter: event.timeFilter,
        durationFilter: event.durationFilter,
        sortBy: event.sortBy,
        ascending: event.ascending,
      );

      emit(state.copyWith(
        isLoading: false,
        recordings: recordings,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteRecordings(
    DeleteRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      final success = await deleteRecordings(event.ids);
      if (success) {
        final recordings = await getRecordings();
        emit(state.copyWith(recordings: recordings));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onUpdateRecording(
    UpdateRecording event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      final success = await repository.updateRecording(event.recording);
      if (success) {
        final recordings = await getRecordings();
        emit(state.copyWith(recordings: recordings));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onSelectAllRecordings(
    SelectAllRecordings event,
    Emitter<RecordingsState> emit,
  ) {
    final selectedIds = event.selectAll
        ? state.recordings.map((r) => r.id).toSet()
        : <String>{};
    emit(state.copyWith(selectedIds: selectedIds));
  }

  void _onToggleRecordingSelection(
    ToggleRecordingSelection event,
    Emitter<RecordingsState> emit,
  ) {
    final selectedIds = Set<String>.from(state.selectedIds);
    if (event.selected) {
      selectedIds.add(event.id);
    } else {
      selectedIds.remove(event.id);
    }
    emit(state.copyWith(selectedIds: selectedIds));
  }

  void _onToggleSelectionMode(
    ToggleSelectionMode event,
    Emitter<RecordingsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: event.enabled,
      selectedIds: event.enabled ? state.selectedIds : {},
    ));
  }
}
