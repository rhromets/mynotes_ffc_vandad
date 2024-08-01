import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/constants/routes.dart';
import 'package:mynotes_ffc_vandad/services/auth/auth_exceptions.dart';
import 'package:mynotes_ffc_vandad/services/auth/auth_service.dart';
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
      await AuthService.firebase().logIn(
        email: _email.text,
        password: _password.text,
      );
      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        // user email is verified
        Navigator.of(context).pushNamedAndRemoveUntil(
          notesRoute,
          (route) => false,
        );
      } else {
        // user email is NOT verified
        Navigator.of(context).pushNamedAndRemoveUntil(
          verifyEmailRoute,
          (route) => false,
        );
      }
    } on UserNotFoundAuthException {
      await showErrorDialog(
        context,
        'User not found',
      );
    } on WrongPasswordAuthException {
      await showErrorDialog(
        context,
        'Wrong password',
      );
    } on InvalidCredentialAuthException {
      await showErrorDialog(context,
        'The supplied auth credential is incorrect, malformed or has expired.',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Authentication error',
      );
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
