import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

//HomePage extend the Stateless Widget..
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
        backgroundColor: Colors.black,
        leading: const Icon(Icons.access_alarm_outlined),
        title: const Text("Register"),
      ),
      body: FutureBuilder(
        // initializing Firebase.......
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          //snapshot is The result of The Future which is the FireBase App....
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  //Email TextField Input Type......
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Enter your email here"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Password TextField input Type....
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: "Enter your password here"),
                  ),
                  TextButton(
                    //OnPressed is an Async Task That Stores User Email and Password Detail to FireBase.....
                    onPressed: () async {
                      //email = _email && password = _password.....
                      final email = _email.text, password = _password.text;
                      // Using The try Catch Block to handle Firebase Exception....
                      try {
                        //await FirebaseAuth Instance For Creating  Email and Password.......
                        final userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                      }
                      // Catch FirebaseAuthException Error
                      on FirebaseAuthException catch (error) {
                        if (error.code == true) {
                          print(error.code);
                        } else {
                          print(error.code);
                        }
                      }
                    },
                    child: const Text("Login"),
                  ),
                ],
              );
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
