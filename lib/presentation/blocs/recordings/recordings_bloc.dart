import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';
import 'package:recording_cleaner/domain/usecases/delete_recordings_usecase.dart';
import 'package:recording_cleaner/domain/usecases/get_recordings_usecase.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_state.dart';

/// 录音列表 BLoC
class RecordingsBloc extends Bloc<RecordingsEvent, RecordingsState> {
  /// 创建[RecordingsBloc]实例
  RecordingsBloc({
    required AppLogger logger,
    required RecordingRepository recordingRepository,
  })  : _logger = logger,
        _recordingRepository = recordingRepository,
        super(RecordingsState.initial()) {
    on<LoadRecordings>(_onLoadRecordings);
    on<DeleteRecordings>(_onDeleteRecordings);
    on<DeleteSelectedRecordings>(_onDeleteSelectedRecordings);
    on<EnterSelectionMode>(_onEnterSelectionMode);
    on<ExitSelectionMode>(_onExitSelectionMode);
    on<ToggleRecordingSelection>(_onToggleRecordingSelection);
    on<ToggleSelectAll>(_onToggleSelectAll);
  }

  final AppLogger _logger;
  final RecordingRepository _recordingRepository;

  Future<void> _onLoadRecordings(
    LoadRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      final recordings = await _recordingRepository.getRecordings();

      emit(state.copyWith(
        recordings: recordings,
        isLoading: false,
      ));
    } catch (e, s) {
      _logger.e('加载录音列表失败', error: e, stackTrace: s);
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
      await _recordingRepository.deleteRecordings(event.ids);

      final recordings = await _recordingRepository.getRecordings();

      emit(state.copyWith(
        recordings: recordings,
      ));
    } catch (e, s) {
      _logger.e('删除录音失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteSelectedRecordings(
    DeleteSelectedRecordings event,
    Emitter<RecordingsState> emit,
  ) async {
    try {
      await _recordingRepository.deleteRecordings(state.selectedRecordings);

      final recordings = await _recordingRepository.getRecordings();

      emit(state.copyWith(
        recordings: recordings,
        selectedRecordings: [],
        isSelectionMode: false,
      ));
    } catch (e, s) {
      _logger.e('删除选中的录音失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  void _onEnterSelectionMode(
    EnterSelectionMode event,
    Emitter<RecordingsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: true,
    ));
  }

  void _onExitSelectionMode(
    ExitSelectionMode event,
    Emitter<RecordingsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: false,
      selectedRecordings: [],
    ));
  }

  void _onToggleRecordingSelection(
    ToggleRecordingSelection event,
    Emitter<RecordingsState> emit,
  ) {
    final selectedRecordings = List<String>.from(state.selectedRecordings);
    if (selectedRecordings.contains(event.id)) {
      selectedRecordings.remove(event.id);
    } else {
      selectedRecordings.add(event.id);
    }
    emit(state.copyWith(
      selectedRecordings: selectedRecordings,
    ));
  }

  void _onToggleSelectAll(
    ToggleSelectAll event,
    Emitter<RecordingsState> emit,
  ) {
    final selectedRecordings =
        state.selectedRecordings.length == state.recordings.length
            ? <String>[]
            : state.recordings.map((e) => e.id).toList();
    emit(state.copyWith(
      selectedRecordings: selectedRecordings,
    ));
  }
}
