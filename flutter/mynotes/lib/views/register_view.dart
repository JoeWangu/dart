import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

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
        title: const Text('Register'),
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
                  // final userCredential =
                  // await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  //     email: email, password: password);
                  // final user = FirebaseAuth.instance.currentUser;
                  AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  // final user = AuthService.firebase().currentUser;
                  await AuthService.firebase().sendEmailVerification();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  }
                  // devtools.log(userCredential.toString());
                } on WeakPasswordAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Weak Password',
                    );
                  }
                } on EmailAlreadyInUseAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Email is already in use',
                    );
                  }
                } on InvalidEmailAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Invalid email entered',
                    );
                  }
                } on GenericAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Failed to register',
                    );
                  }
                }
                // on FirebaseAuthException catch (e) {
                // if (e.code == 'weak-password') {
                //   // devtools.log('Weak Password');
                //   if (context.mounted) {
                //     await showErrorDialog(
                //       context,
                //       'Weak Password',
                //     );
                //   }
                // } else if (e.code == 'email-already-in-use') {
                //   // devtools.log('Email is already in use');
                //   if (context.mounted) {
                //     await showErrorDialog(
                //       context,
                //       'Email is already in use',
                //     );
                //   }
                // } else if (e.code == 'invalid-email') {
                //   // devtools.log('Invalid email entered');
                // if (context.mounted) {
                //   await showErrorDialog(
                //     context,
                //     'Invalid email entered',
                //   );
                // }
                // } else {
                //   // devtools.log(e.code.toString());
                //   if (context.mounted) {
                //     await showErrorDialog(
                //       context,
                //       'Error: ${e.code}',
                //     );
                //   }
                // }
                // }
                // catch (e) {
                //   if (context.mounted) {
                //     await showErrorDialog(
                //       context,
                //       'Error: ${e.toString()}',
                //     );
                //   }
                // }
              },
              child: const Text('Register')),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already Registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
