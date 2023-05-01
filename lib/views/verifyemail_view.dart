import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// VerifyEmail  View Page..
class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
      ),
      body:Column( 
     children : [
        const Text("Please enter your email address"),
        TextButton(
          onPressed: () async {
            // await Email Verification......
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send Email Verification"),
        )
      ],)
    );
  }
}
