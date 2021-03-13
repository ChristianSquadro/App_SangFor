/// Routing handler for the app
class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
// We will create 'HomePage' later
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
  const RouteException( this.message);
}