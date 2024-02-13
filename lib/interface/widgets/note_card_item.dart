import 'package:flutter/material.dart';
import 'package:flutter_floor/constants/colors.dart';
import 'package:flutter_floor/constants/typography.dart';
import 'package:flutter_floor/model/notes.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
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
                    Text(
                      notes.noteTitle,
                      style: AppTypography.noteTitle,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      notes.noteContent,
                      style: AppTypography.noteContent,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      notes.noteDate,
                      style: AppTypography.noteDate,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onNoteDeleted,
                icon: SvgPicture.asset(
                  'assets/trash.svg',
                  color: deleteIconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
