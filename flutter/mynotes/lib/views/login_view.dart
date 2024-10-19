import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

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
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  // navigateToNotes(() {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //     notesRoute,
                  //     (route) => false,
                  //   );
                  // }, email, password);
                  await AuthService.firebase().logIn(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    // user's email is verified
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (route) => false,
                      );
                    }
                  } else {
                    // user's email is not verified
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute,
                        (route) => false,
                      );
                    }
                  }
                } on UserNotFoundAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'User not found',
                    );
                  }
                } on WrongPasswordAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Wrong Credentials',
                    );
                  }
                } on GenericAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Authentication Error',
                    );
                  }
                }
              },
              // on FirebaseAuthException catch (e) {
              //   // devtools.log(e.code);
              //   if (e.code == 'user-not-found') {
              //     // devtools.log('User not found');
              //     if (context.mounted) {
              //       await showErrorDialog(
              //         context,
              //         'User not found',
              //       );
              //     }
              //   } else if (e.code == 'wrong-password') {
              //     // devtools.log('Wrong Password');
              //     if (context.mounted) {
              //       await showErrorDialog(
              //         context,
              //         'Wrong Credentials',
              //       );
              //     }
              //   } else {
              //     // devtools.log('Invalid Credentials');
              //     if (context.mounted) {
              //       await showErrorDialog(
              //         context,
              //         'Error: ${e.code}',
              //       );
              //     }
              //   }
              // } catch (e) {
              //   if (context.mounted) {
              //     await showErrorDialog(
              //       context,
              //       'Error: ${e.toString()}',
              //     );
              //   }
              // }
              // },
              child: const Text('Login')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not Registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}

// Future<void> navigateToNotes(Function() navigate, email, password) async {
//   // final userCredential =
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email,
//     password: password,
//   );
//   // devtools.log(userCredential.toString());
//   navigate();
// }
