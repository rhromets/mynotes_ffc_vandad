import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes_ffc_vandad/constants/routes.dart';
import 'package:mynotes_ffc_vandad/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  Future<void> _register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      final user = FirebaseAuth.instance.currentUser;
      user?.sendEmailVerification();
      Navigator.of(context).pushNamed(verifyEmailRoute);
    } on FirebaseAuthException catch (e) {
      devtools.log('FirebaseAuthException: ${e.code} - ${e.message}');
      await _handleFirebaseAuthException(e);
    } catch (e) {
      if (mounted) {
        showErrorDialog(context, 'General error: $e');
      }
      devtools.log('General error: $e');
    }
  }

  Future<void> _handleFirebaseAuthException(FirebaseAuthException e) async {
    if (e.code == 'weak-password') {
      showErrorDialog(context, 'Weak password');
      devtools.log('Weak-password.');
    } else if (e.code == 'email-already-in-use') {
      showErrorDialog(context, 'Email is already in use');
      devtools.log('Email is already in use.');
    } else if (e.code == 'invalid-email') {
      showErrorDialog(context, 'The email address is invalid');
      devtools.log('The email address is invalid.');
    } else {
      showErrorDialog(context, 'Something went wrong: ${e.message}');
      devtools.log('Something went wrong: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
            onPressed: _register,
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
