import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/constants/routes.dart';
import 'package:mynotes_ffc_vandad/views/login_view.dart';
import 'package:mynotes_ffc_vandad/views/notes_view.dart';
import 'package:mynotes_ffc_vandad/views/register_view.dart';
import 'package:mynotes_ffc_vandad/views/verify_email_view.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
      home: const HomePage(),
    );
  }
}
