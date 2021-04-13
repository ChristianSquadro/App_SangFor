import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget navigateTo;

  FadePageRoute({required this.navigateTo})
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

class SlideUpPageRoute extends PageRouteBuilder {
  final Widget navigateTo;
  SlideUpPageRoute({required this.navigateTo})
      : super(
    pageBuilder: (context, _, __) => navigateTo,
    transitionsBuilder: (context, animation, _, child) => SlideTransition(
       position: Tween<Offset>(
        begin: Offset(0,1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    )
  );
}


