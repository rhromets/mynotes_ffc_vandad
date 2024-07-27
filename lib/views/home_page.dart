import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/firebase_options.dart';
import 'package:mynotes_ffc_vandad/views/login_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if (user?.emailVerified ?? false) {
              //   debugPrint('You are verified');
              //   return const Text('Done');
              // } else {
              //   debugPrint('Yo need to verify your email');
              //   return const VerifyEmailView();
              // }
              return const LoginView();
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
