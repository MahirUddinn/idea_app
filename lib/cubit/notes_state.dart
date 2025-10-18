import 'package:akjfkgnjkawgnf/model/note.dart';

enum NotesStatus { loading, loaded, error }

class NotesState {
  final NotesStatus status;
  final List<Note> notes;
  final String? errorMessage;

  const NotesState({
    this.status = NotesStatus.loading,
    this.notes = const [],
    this.errorMessage,
  });

  NotesState copyWith({
    NotesStatus? status,
    List<Note>? notes,
    String? errorMessage,
  }) {
    return NotesState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}