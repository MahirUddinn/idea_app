import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akjfkgnjkawgnf/model/note.dart';
import 'package:akjfkgnjkawgnf/data/database_helper.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final DatabaseHelper _databaseHelper;

  NotesCubit(this._databaseHelper) : super(const NotesState());

  void loadNotes() async {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      final notes = await _databaseHelper.getNotes();
      emit(state.copyWith(status: NotesStatus.loaded, notes: notes));
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.error, errorMessage: "Failed to load notes: $e"));
    }
  }

  void addNote(Note note) async {
    try {
      await _databaseHelper.addNote(note);
      loadNotes();
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.error, errorMessage: "Failed to add note: $e"));
    }
  }

  void deleteNote(int id) async {
    try {
      await _databaseHelper.deleteNote(id);
      loadNotes();
    } catch (e) {
      emit(state.copyWith(status: NotesStatus.error, errorMessage: "Failed to delete note: $e"));
    }
  }
}