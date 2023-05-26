//Alert Dialog....
import 'package:flutter/material.dart';
import 'dart:developer' as devtools
    show
        log; // it's a Default package used to Print Whatever your code returns...

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
