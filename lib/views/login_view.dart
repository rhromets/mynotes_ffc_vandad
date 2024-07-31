import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes_ffc_vandad/constants/routes.dart';
import 'package:mynotes_ffc_vandad/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      devtools.log('Successfully signed in!');
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          notesRoute,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      devtools.log('FirebaseAuthException: ${e.code} - ${e.message}');
      devtools.log('Additional Information: ${e.credential}, ${e.email}');
      await _handleFirebaseAuthException(e);
    } catch (e) {
      devtools.log('General error: $e');
      if (mounted) {
        showErrorDialog(context, 'General error: $e');
      }
    }
  }

  Future<void> _handleFirebaseAuthException(FirebaseAuthException e) async {
    if (e.code == 'user-not-found') {
      await showErrorDialog(context, 'User not found');
      devtools.log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      await showErrorDialog(context, 'Wrong password');
      devtools.log('Wrong password provided for that user.');
    } else if (e.code == 'invalid-email') {
      await showErrorDialog(context, 'The email address is badly formatted.');
      devtools.log('The email address is badly formatted.');
    } else if (e.code == 'invalid-credential') {
      await showErrorDialog(context,
          'The supplied auth credential is incorrect, malformed or has expired.');
      devtools.log(
          'The supplied auth credential is incorrect, malformed or has expired.');
    } else {
      await showErrorDialog(context, 'Something went wrong: ${e.message}');
      devtools.log('Something went wrong: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () => _login(context),
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}
