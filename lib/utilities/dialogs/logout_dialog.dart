import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/utilities/dialogs/generics_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericsDialog(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancel': false,
      'OK': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
