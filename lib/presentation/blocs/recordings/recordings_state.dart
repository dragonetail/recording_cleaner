import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

abstract class RecordingsState extends Equatable {
  const RecordingsState();

  @override
  List<Object?> get props => [];
}

class RecordingsInitial extends RecordingsState {}

class RecordingsLoading extends RecordingsState {}

class RecordingsLoaded extends RecordingsState {
  final List<RecordingEntity> recordings;
  final bool isSelectionMode;
  final Set<String> selectedIds;
  final String? timeFilter;
  final String? durationFilter;
  final String? sortBy;
  final bool? ascending;

  const RecordingsLoaded({
    required this.recordings,
    this.isSelectionMode = false,
    this.selectedIds = const {},
    this.timeFilter,
    this.durationFilter,
    this.sortBy,
    this.ascending,
  });

  @override
  List<Object?> get props => [
        recordings,
        isSelectionMode,
        selectedIds,
        timeFilter,
        durationFilter,
        sortBy,
        ascending,
      ];

  RecordingsLoaded copyWith({
    List<RecordingEntity>? recordings,
    bool? isSelectionMode,
    Set<String>? selectedIds,
    String? timeFilter,
    String? durationFilter,
    String? sortBy,
    bool? ascending,
  }) {
    return RecordingsLoaded(
      recordings: recordings ?? this.recordings,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedIds: selectedIds ?? this.selectedIds,
      timeFilter: timeFilter ?? this.timeFilter,
      durationFilter: durationFilter ?? this.durationFilter,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }
}

class RecordingsError extends RecordingsState {
  final String message;

  const RecordingsError(this.message);

  @override
  List<Object?> get props => [message];
}
