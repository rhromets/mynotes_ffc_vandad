import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes_ffc_vandad/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes_ffc_vandad/services/auth/bloc/auth_event.dart';
import 'package:mynotes_ffc_vandad/services/auth/bloc/auth_state.dart';
import 'package:mynotes_ffc_vandad/views/login_view.dart';
import 'package:mynotes_ffc_vandad/views/notes/notes_view.dart';
import 'package:mynotes_ffc_vandad/views/verify_email_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
