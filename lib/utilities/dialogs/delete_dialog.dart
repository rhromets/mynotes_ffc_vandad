import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/utilities/dialogs/generics_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericsDialog(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    optionsBuilder: () => {
      'Cancel': false,
      'YES': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
