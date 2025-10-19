import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akjfkgnjkawgnf/model/note.dart';
import 'package:akjfkgnjkawgnf/data/app_database.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final AppDatabase databaseHelper;

  NotesCubit(this.databaseHelper) : super(const NotesState());

  void loadNotes() async {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      final notes = await databaseHelper.getNotes();
      emit(state.copyWith(status: NotesStatus.loaded, notes: notes));
    } catch (e) {
      emit(
        state.copyWith(
          status: NotesStatus.error,
          errorMessage: "Failed to load note: $e",
        )
      );
    }
  }

  void addNote(Note note) async {
    try {
      await databaseHelper.addNote(note);
      emit(state.copyWith(notes: [note,...state.notes]));

    } catch (e) {
      emit(
        state.copyWith(
          status: NotesStatus.error,
          errorMessage: "Failed to add note: $e",
        ),
      );
    }
  }

  void deleteNote(int id) async {
    try {
      await databaseHelper.deleteNote(id);
    } catch (e) {
      emit(
        state.copyWith(
          status: NotesStatus.error,
          errorMessage: "Failed to delete note: $e",
        ),
      );
    }
  }

  void updateNote(Note note) async {
    try {
      await databaseHelper.updateNote(note);
      final updatedNotes = state.notes.map((n) {
        return n.id == note.id ? note : n;
      }).toList();
      emit(state.copyWith(notes: updatedNotes));

    } catch (e) {
      emit(
        state.copyWith(
          status: NotesStatus.error,
          errorMessage: "Failed to update note: $e",
        ),
      );
    }
  }
}
