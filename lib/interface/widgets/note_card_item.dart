import 'package:flutter/material.dart';
import 'package:flutter_floor/model/notes.dart';

class NoteCardItem extends StatelessWidget {
  final Notes notes;
  final VoidCallback onNoteClicked;
  final VoidCallback onNoteDeleted;

  const NoteCardItem({
    Key? key,
    required this.notes,
    required this.onNoteClicked,
    required this.onNoteDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onNoteClicked,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notes.id.toString()),
                    const SizedBox(height: 8.0),
                    Text(notes.noteTitle),
                    const SizedBox(height: 8.0),
                    Text(notes.noteContent),
                    const SizedBox(height: 8.0),
                    Text(notes.noteDate),
                  ],
                ),
              ),
              IconButton(
                onPressed: onNoteDeleted,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
