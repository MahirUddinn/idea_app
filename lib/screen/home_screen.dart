import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_cubit.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_state.dart';
import 'package:akjfkgnjkawgnf/model/note.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  Widget _getUserInput(){
    return Row(
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
    );
  }

  Widget _getBody(){
    return Expanded(
      child: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state.status == NotesStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status == NotesStatus.loaded) {
            if (state.notes.isEmpty) {
              return Center(child: Text('no notes detected'));
            }
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return Dismissible(
                  key: ValueKey(note.id),
                  onDismissed: (direction) {
                    context.read<NotesCubit>().deleteNote(note.id!);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(note.content),
                    trailing: IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        SharePlus.instance.share(ShareParams(text: note.content));
                      },
                    ),
                  ),
                );
              },
            );
          }
          if (state.status == NotesStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'error message'));
          }
          return Container();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().loadNotes();
  }


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
            child: _getUserInput(),
          ),
          _getBody(),
        ],
      ),
    );
  }
}