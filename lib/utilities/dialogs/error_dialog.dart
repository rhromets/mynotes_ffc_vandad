import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/utilities/dialogs/generics_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericsDialog<void>(
    context: context,
    title: 'An error occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
