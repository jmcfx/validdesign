import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:validdesign/constants/routes.dart';
import '../showDialog/error_dialog.dart';

//Login View extend the Stateless Widget..
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //TextField Controller ......
  late final TextEditingController _email;
  late final TextEditingController _password;
//The essence of the initState method is to initialize stateful properties that are needed by the widget and to perform any other setup that needs to be done before the widget is rendered.
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
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          //Email Text Field ......
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: "Enter your email here"),
          ),
          const SizedBox(
            height: 10,
          ),
          // Password TextField input Type....
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: "Enter your password here"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text, password = _password.text;
              // Using The try Catch Block to handle Firebase Exception....
              try {
                //await FirebaseAuth Instance For Creating  Email and Password.......
                final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                //route to the welcome screen.....
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(dashboardRoute, (route) => false);
              }
              //  Catch FirebaseAuthException Error
              on FirebaseAuthException catch (e) {
                devtools.log(e.code.toString());
                if (e.code == "user-not-found") {
                  await showErrorDialog(context, "user-not-found");
                } else if (e.code == "wrong-password") {
                  await showErrorDialog(context, "wrong-password");
                } else {
                  await showErrorDialog(context, "Error : ${e.code}");
                }
              
              }
              //Catch any other Exception That is FireBaseAuthException.... 
              catch (e) {
                await showErrorDialog(context, e.toString());
              }
            },
            child: const Text("Login"),
          ),
          // Not registered TextButton ...
          TextButton(
            onPressed: () {
              //Clicking This Button Takes you to the Register View Page|| Named route to Register View Page ....
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Not registered yet? register here"),
          ),
        ],
      ),
    );
  }
}
