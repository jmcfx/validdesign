//Authentication Error Dialog ....The void Function Doesn't return any value..
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("An Error Occurred"),
        content: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                //Pop, dismiss The dialog...
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ],
      );
    },
  );
}
