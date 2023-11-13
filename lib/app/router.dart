import 'package:flutter/material.dart';
import 'package:moboom_app/features/home/presentation/pages/home_page.dart';

class Routes {
  static const kHomePage = '/';
}

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
