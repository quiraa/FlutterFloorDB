import 'package:flutter/material.dart';
import 'package:flutter_floor/model/notes.dart';

class NoteCardItem extends StatefulWidget {
  final Notes notes;
  Function onNoteClicked;
  Function onNoteDeleted;

  NoteCardItem(
      {Key? key,
      required this.notes,
      required this.onNoteClicked,
      required this.onNoteDeleted})
      : super(key: key);

  @override
  _NoteCardItemState createState() => _NoteCardItemState();
}

class _NoteCardItemState extends State<NoteCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => widget.onNoteClicked,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.notes.noteTitle),
                  const SizedBox(height: 8.0),
                  Text(widget.notes.noteContent),
                  const SizedBox(height: 8.0),
                  Text(widget.notes.noteDate),
                ],
              ),
              IconButton(
                onPressed: () => widget.onNoteDeleted,
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
