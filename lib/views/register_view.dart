import 'package:flutter/material.dart';
import 'package:mynotes_ffc_vandad/constants/routes.dart';
import 'package:mynotes_ffc_vandad/services/auth/auth_exceptions.dart';
import 'package:mynotes_ffc_vandad/services/auth/auth_service.dart';
import 'package:mynotes_ffc_vandad/utilities/dialogs/error_dialog.dart';

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
      await AuthService.firebase().createUser(
        email: _email.text,
        password: _password.text,
      );
      AuthService.firebase().sendEmailVerification();
      Navigator.of(context).pushNamed(verifyEmailRoute);
    } on WeakPasswordAuthException {
      await showErrorDialog(
        context,
        'Weak password',
      );
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(
        context,
        'Email is already in use',
      );
    } on InvalidEmailAuthException {
      await showErrorDialog(
        context,
        'The email address is invalid',
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
