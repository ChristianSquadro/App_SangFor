import 'package:app_sangfor/routes/home_page.dart';
import 'package:flutter/material.dart';

/// Routing handler for the app
class RouteGenerator {
  static const homePage = '/';

  //prevent the class to be accidentally instantiated using the implicit default constructor because the class is just a "wrapper"
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<HomePage>(
          //Very common use, is when we need to push a new route with Navigator but the context variable in the builder is not going to be used
          builder: (_) => const HomePage(),
        );

      default:
        throw RouteException("Route not found");

    }

  }



}

/// Exception thrown when a given route doesn't exist
class RouteException implements Exception {
  final String message;
  const RouteException( this.message);
}