import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/firebase_options.dart';
import 'package:mynotes_ffc_vandad/views/login_view.dart';
import 'package:mynotes_ffc_vandad/views/notes_view.dart';
import 'package:mynotes_ffc_vandad/views/verify_email_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void reloadUser(User user) async {
    await user.reload();
  }
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              reloadUser(user);
              final refreshedUser = FirebaseAuth.instance.currentUser;
              if (refreshedUser != null && refreshedUser.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
