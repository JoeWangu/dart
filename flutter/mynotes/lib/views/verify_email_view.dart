import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify your account"),
          const Padding(padding: EdgeInsets.all(8)),
          const Text(
              "If you haven't received a verification email yet, press the button below"),
          TextButton(
              onPressed: () async {
                // final user = FirebaseAuth.instance.currentUser;
                // await user?.sendEmailVerification();
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('send email verification')),
          TextButton(
              onPressed: () async {
                // await FirebaseAuth.instance.signOut();
                await AuthService.firebase().logOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                }
              },
              child: const Text('Restart')),
        ],
      ),
    );
  }
}