import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

abstract class RecordingsEvent extends Equatable {
  const RecordingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecordings extends RecordingsEvent {
  final String? timeFilter;
  final String? durationFilter;
  final String? sortBy;
  final bool? ascending;

  const LoadRecordings({
    this.timeFilter,
    this.durationFilter,
    this.sortBy,
    this.ascending,
  });

  @override
  List<Object?> get props => [timeFilter, durationFilter, sortBy, ascending];
}

class DeleteRecordings extends RecordingsEvent {
  final List<String> ids;

  const DeleteRecordings(this.ids);

  @override
  List<Object?> get props => [ids];
}

class UpdateRecording extends RecordingsEvent {
  final RecordingEntity recording;

  const UpdateRecording(this.recording);

  @override
  List<Object?> get props => [recording];
}

class ToggleSelectionMode extends RecordingsEvent {
  final bool enabled;

  const ToggleSelectionMode(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ToggleRecordingSelection extends RecordingsEvent {
  final String id;
  final bool selected;

  const ToggleRecordingSelection(this.id, this.selected);

  @override
  List<Object?> get props => [id, selected];
}

class SelectAllRecordings extends RecordingsEvent {
  final bool selectAll;

  const SelectAllRecordings(this.selectAll);

  @override
  List<Object?> get props => [selectAll];
}
