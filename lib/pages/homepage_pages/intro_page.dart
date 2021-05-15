import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center( child: Image(image: AssetImage("assets/intro_sangfor_logo.png"),height: 300,width:300)),
    );
  }
}