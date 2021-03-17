import 'package:app_sangfor/routes/home_page.dart';
import 'package:flutter/material.dart';

/// Route management class
class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<HomePage>(
          builder: (_) => const HomePage(),
        );
      default:
        throw RouteException("Route not found");
    }
  }

  static const homePage = '/';
}

/// Exception thrown when a given route doesn't exist
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
