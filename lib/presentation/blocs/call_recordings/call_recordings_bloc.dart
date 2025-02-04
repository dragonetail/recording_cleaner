import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';
import 'package:recording_cleaner/presentation/blocs/call_recordings/call_recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/call_recordings/call_recordings_state.dart';

/// 通话录音列表 BLoC
class CallRecordingsBloc
    extends Bloc<CallRecordingsEvent, CallRecordingsState> {
  /// 创建[CallRecordingsBloc]实例
  CallRecordingsBloc({
    required AppLogger logger,
    required CallRecordingRepository callRecordingRepository,
  })  : _logger = logger,
        _callRecordingRepository = callRecordingRepository,
        super(CallRecordingsState.initial()) {
    on<LoadCallRecordings>(_onLoadCallRecordings);
    on<DeleteCallRecordings>(_onDeleteCallRecordings);
    on<DeleteSelectedCallRecordings>(_onDeleteSelectedCallRecordings);
    on<EnterSelectionMode>(_onEnterSelectionMode);
    on<ExitSelectionMode>(_onExitSelectionMode);
    on<ToggleCallRecordingSelection>(_onToggleCallRecordingSelection);
    on<ToggleSelectAll>(_onToggleSelectAll);
    on<ToggleCallRecordingImportance>(_onToggleCallRecordingImportance);
  }

  final AppLogger _logger;
  final CallRecordingRepository _callRecordingRepository;

  Future<void> _onLoadCallRecordings(
    LoadCallRecordings event,
    Emitter<CallRecordingsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      final recordings = await _callRecordingRepository.getCallRecordings();

      emit(state.copyWith(
        recordings: recordings,
        isLoading: false,
      ));
    } catch (e, s) {
      _logger.e('加载通话录音列表失败', error: e, stackTrace: s);
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteCallRecordings(
    DeleteCallRecordings event,
    Emitter<CallRecordingsState> emit,
  ) async {
    try {
      await _callRecordingRepository.deleteCallRecordings(event.ids);

      final recordings = await _callRecordingRepository.getCallRecordings();

      emit(state.copyWith(
        recordings: recordings,
      ));
    } catch (e, s) {
      _logger.e('删除通话录音失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteSelectedCallRecordings(
    DeleteSelectedCallRecordings event,
    Emitter<CallRecordingsState> emit,
  ) async {
    try {
      await _callRecordingRepository
          .deleteCallRecordings(state.selectedRecordings);

      final recordings = await _callRecordingRepository.getCallRecordings();

      emit(state.copyWith(
        recordings: recordings,
        selectedRecordings: [],
        isSelectionMode: false,
      ));
    } catch (e, s) {
      _logger.e('删除选中的通话录音失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  void _onEnterSelectionMode(
    EnterSelectionMode event,
    Emitter<CallRecordingsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: true,
    ));
  }

  void _onExitSelectionMode(
    ExitSelectionMode event,
    Emitter<CallRecordingsState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: false,
      selectedRecordings: [],
    ));
  }

  void _onToggleCallRecordingSelection(
    ToggleCallRecordingSelection event,
    Emitter<CallRecordingsState> emit,
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
    Emitter<CallRecordingsState> emit,
  ) {
    final selectedRecordings =
        state.selectedRecordings.length == state.recordings.length
            ? <String>[]
            : state.recordings.map((e) => e.id).toList();
    emit(state.copyWith(
      selectedRecordings: selectedRecordings,
    ));
  }

  Future<void> _onToggleCallRecordingImportance(
    ToggleCallRecordingImportance event,
    Emitter<CallRecordingsState> emit,
  ) async {
    try {
      await _callRecordingRepository.toggleCallRecordingImportance(event.id);

      final recordings = await _callRecordingRepository.getCallRecordings();

      emit(state.copyWith(
        recordings: recordings,
      ));
    } catch (e, s) {
      _logger.e('切换通话录音重要性失败', error: e, stackTrace: s);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }
}
