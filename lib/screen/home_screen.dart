import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_cubit.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_state.dart';
import 'package:akjfkgnjkawgnf/model/note.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter a note',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final content = _textController.text;
                    if (content.isNotEmpty) {
                      final note = Note(content: content);
                      context.read<NotesCubit>().addNote(note);
                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                if (state.status == NotesStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.status == NotesStatus.loaded) {
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      return ListTile(
                        title: Text(note.content),
                        trailing: IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            Share.share(note.content);
                          },
                        ),
                      );
                    },
                  );
                }
                if (state.status == NotesStatus.error) {
                  return Center(child: Text(state.errorMessage ?? 'An error occurred'));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}