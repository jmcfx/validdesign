// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:validdesign/views/login_view.dart';
import 'package:validdesign/views/register_view.dart';
import 'package:validdesign/views/verifyemail_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      //Home Page is a Stateless Widget Constructor....
      home: const HomePage(),
      //Creating a named route For Users LoginView Page and Register View Page.......
      routes: {
        "/login/": (context) => const LoginView(),
        "/register/": (context) => const RegisterView(),
      },
    ),
  );
}

// HomePAge Stateless Widget || returns a Future Builder....
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //initializing the FireBase App......
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        //Future builder comes with a Builder Prop....
        builder: (context, snapshot) {
          //snapshot.connectionState is mainly For internet connection......
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // if (user?.emailVerified ?? false) {
            //   print(user);
            //   // It returns Done if Users Email is Verified......
            //   return const Text("Done");
            // } else {
            //   // It returns The VerifyEmail Stateless Widget, if Users isn't verified.....
            //   return const VerifyEmail();
            // }
              return const LoginView();
            default:
              // The HomePage displays a "CircularProgressIndicator" by Default if The Network is bad......
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("Processing"),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(),
                ],
              ));
          }
        },
      ),
    );
  }
}
