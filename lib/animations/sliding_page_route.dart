import 'package:flutter/material.dart';

class SlidingPageRoute1 extends PageRouteBuilder {
  final Widget navigateTo;
  SlidingPageRoute1({required this.navigateTo})
      : super(
          pageBuilder: (context, _, __) => navigateTo,
          transitionsBuilder: (context, animation, _, child) => FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlidingPageRoute2 extends PageRouteBuilder {
  final Widget navigateTo;
  SlidingPageRoute2({required this.navigateTo})
      : super(
    pageBuilder: (context, _, __) => navigateTo,
    transitionsBuilder: (context, animation, _, child) => ScaleTransition(
      scale: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: child,
    )
  );
}


