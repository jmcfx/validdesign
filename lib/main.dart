// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:validdesign/constants/routes.dart';
import 'package:validdesign/views/login_view.dart';
import 'package:validdesign/views/register_view.dart';
import 'package:validdesign/views/verifyemail_view.dart';
import 'dart:developer' as devtools show log ;// it's a Default package used to Print Whatever your code returns... 

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
      //Creating a named route...
      routes: {
        //route is a Map The has a String as its Key Then a function As its value......
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        dashboardRoute: (context) => const DashboardView(),
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
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const DashboardView();
                } else {
                  return const VerifyEmail();
                }
              } else {
                return const LoginView();
              }
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

//  Enumeration That Defines The PopUp Menu Items ......
enum MenuAction { logout }

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(1.0),
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(0.8),
          child: Row(
            children: const [],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: <Widget>[
          //We Specified The Value Type <MenuAction> Which The PopupMenuButton will be managing|| MenuAction is an Enum......
          PopupMenuButton<MenuAction>(
            //The itemBuilder function is called to create the initial set of menu items
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  // The value is passed to onSelected...
                  value: MenuAction.logout,
                  child: Text("logout"),
                ),
              ];
            },
            //We Specified the onSelected Should Take Only The values that's associated With The MenuAction Enum....
            onSelected: (MenuAction value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login/", (_) => false);
                  }
                  devtools.log(shouldLogOut.toString());
                  break;
              }
            },
          )
        ],
      ),
      body: const Text(""),
      drawer: const Drawer(),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  //The showDialog is a function that returns a Future with an Optional Value so value can be null...
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign Out Here"),
        content: const Text("Are you sure you want to Logout "),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  ).then((value) {
    devtools.log(value.toString());
    return value ?? false;
  });
}
