import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context,String error) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(''),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Connection Error!'),
              Text(error),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}