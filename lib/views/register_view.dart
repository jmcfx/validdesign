import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Column(children: [
          //Email textField.....
          const TextField(
            decoration: InputDecoration(
              hintText: "Enter Your Email Here",
            ),
          ),
          TextButton(onPressed: () {}, child: const Text("Register")),
          TextButton(
            onPressed: () {
              //Named route to Login View_page....
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/login/", (route) => false);
            },
            child: const Text("Already Registered? Login Here"),
          )
        ]));
  }
}
