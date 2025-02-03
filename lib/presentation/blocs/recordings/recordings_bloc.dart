import 'package:flutter_bloc/flutter_bloc.dart';
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
  }) : super(RecordingsInitial()) {
    on<RecordingsEvent>((event, emit) async {
      if (event is LoadRecordings) {
        await _onLoadRecordings(event, emit);
      } else if (event is DeleteRecordings) {
        await _onDeleteRecordings(event, emit);
      } else if (event is UpdateRecording) {
        await _onUpdateRecording(event, emit);
      } else if (event is ToggleSelectionMode) {
        _onToggleSelectionMode(event, emit);
      } else if (event is ToggleRecordingSelection) {
        _onToggleRecordingSelection(event, emit);
      } else if (event is SelectAllRecordings) {
        _onSelectAllRecordings(event, emit);
      }
    });
  }

  Future<void> _onLoadRecordings(
    LoadRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      emit(RecordingsLoading());
      final recordings = await getRecordings(
        timeFilter: event.timeFilter,
        durationFilter: event.durationFilter,
        sortBy: event.sortBy,
        ascending: event.ascending,
      );
      emit(RecordingsLoaded(recordings: recordings));
    } catch (e) {
      emit(RecordingsError(e.toString()));
    }
  }

  Future<void> _onDeleteRecordings(
    DeleteRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    if (state is RecordingsLoaded) {
      try {
        final success = await deleteRecordings(event.ids);
        if (success) {
          final currentState = state as RecordingsLoaded;
          final updatedRecordings = currentState.recordings
              .where((recording) => !event.ids.contains(recording.id))
              .toList();
          emit(currentState.copyWith(
            recordings: updatedRecordings,
            selectedIds: currentState.selectedIds
                .where((id) => !event.ids.contains(id))
                .toSet(),
          ));
        }
      } catch (e) {
        emit(RecordingsError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateRecording(
    UpdateRecording event,
    Emitter<RecordingsState> emit,
  ) async {
    if (state is RecordingsLoaded) {
      try {
        final success = await repository.updateRecording(event.recording);
        if (success) {
          final currentState = state as RecordingsLoaded;
          final updatedRecordings = currentState.recordings.map((recording) {
            return recording.id == event.recording.id
                ? event.recording
                : recording;
          }).toList();

          emit(currentState.copyWith(recordings: updatedRecordings));
        }
      } catch (e) {
        emit(RecordingsError(e.toString()));
      }
    }
  }

  void _onToggleSelectionMode(
    ToggleSelectionMode event,
    Emitter<RecordingsState> emit,
  ) {
    if (state is RecordingsLoaded) {
      final currentState = state as RecordingsLoaded;
      emit(currentState.copyWith(
        isSelectionMode: event.enabled,
        selectedIds: event.enabled ? currentState.selectedIds : {},
      ));
    }
  }

  void _onToggleRecordingSelection(
    ToggleRecordingSelection event,
    Emitter<RecordingsState> emit,
  ) {
    if (state is RecordingsLoaded) {
      final currentState = state as RecordingsLoaded;
      final selectedIds = Set<String>.from(currentState.selectedIds);
      if (event.selected) {
        selectedIds.add(event.id);
      } else {
        selectedIds.remove(event.id);
      }
      emit(currentState.copyWith(selectedIds: selectedIds));
    }
  }

  void _onSelectAllRecordings(
    SelectAllRecordings event,
    Emitter<RecordingsState> emit,
  ) {
    if (state is RecordingsLoaded) {
      final currentState = state as RecordingsLoaded;
      emit(currentState.copyWith(
        selectedIds: event.selectAll
            ? currentState.recordings.map((r) => r.id).toSet()
            : {},
      ));
    }
  }
}
