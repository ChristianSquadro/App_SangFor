import 'package:app_sangfor/animations/sliding_page_route.dart';
import 'package:app_sangfor/routes/VM_page.dart';
import 'package:app_sangfor/routes/WebView_Page.dart';
import 'package:app_sangfor/routes/about.dart';
import 'package:app_sangfor/routes/home_page.dart';
import 'package:app_sangfor/pages/homepage_pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'routes/vm_more_about.dart';

/// Route management class
class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<HomePage>(
          builder: (_) => const HomePage(),

        );

      case dashboard:
        return  FadePageRoute(
            navigateTo: const DashBoard()
        );

      case vmPage:
        return FadePageRoute(
            navigateTo: const VMPage()
        );

      case about:
        return FadePageRoute(
            navigateTo: const About()
        );

      case webViewConsole:
        return SlideUpPageRoute(
            navigateTo: const WebViewConsole()
        );

      case VMMoreAbout:
        return SlideUpPageRoute(
            navigateTo: const VMMoreAboutPage()
        );

      default:
        throw RouteException("Route not found");

    }
  }

  static const homePage = '/';
  static const vmPage = '/VM';
  static const dashboard = '/DashBoard';
  static const webViewConsole = '/DashBoard/WebViewConsole';
  static const VMMoreAbout = '/DashBoard/VMMoreAbout';
  static const about = '/About';
}

/// Exception thrown when a given route doesn't exist
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
