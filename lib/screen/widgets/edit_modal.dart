import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_cubit.dart';
import 'package:akjfkgnjkawgnf/model/note.dart';

class EditModal extends StatefulWidget {
  const EditModal({super.key, required this.id});

  final int id;

  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  final TextEditingController _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _editController,
            decoration: InputDecoration(hintText: 'Enter edited note'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final content = _editController.text;
                  if (content.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Enter valid data")));
                  } else {
                    final note = Note(content: content, id: widget.id);
                    context.read<NotesCubit>().updateNote(note);
                    _editController.clear();
                    Navigator.of(context).pop();
                  }
                },
                child: Text("Save Edit"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
