import 'package:flutter/material.dart';
import 'package:moboom_app/features/home/presentation/pages/home_page.dart';

class Routes {
  static const kHomePage = '/';
}

// This router can be extended to have more routes in the future
// or just replace it with some library like go_router or auto_route
Route<dynamic> router(RouteSettings settings) {
  switch (settings.name) {
    case Routes.kHomePage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Text('Placeholder'),
      );
  }
}
