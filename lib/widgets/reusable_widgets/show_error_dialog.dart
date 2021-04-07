import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context,Object error) async {
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
              Text((error as DioError).message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}