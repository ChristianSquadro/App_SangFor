import 'package:flutter/material.dart';

class SlidingPageRoute extends PageRouteBuilder {
  final Widget navigateTo;
  SlidingPageRoute({required this.navigateTo})
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
