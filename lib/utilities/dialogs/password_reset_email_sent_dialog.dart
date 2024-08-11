import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/utilities/dialogs/generics_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericsDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have now sent you a password reset link. Please check your email.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
