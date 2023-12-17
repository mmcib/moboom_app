import 'package:flutter/material.dart';
import 'package:moboom_app/features/auth/presentation/pages/initial_page.dart';
import 'package:moboom_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:moboom_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:moboom_app/features/home/presentation/pages/home_page.dart';

class Routes {
  static const kInitialPage = '/initialPage';
  static const kHomePage = '/';
  static const kSignInPage = '/signIn';
  static const kSignUpPage = '/signUp';
}

// This router can be extended to have more routes in the future
// or just replace it with some library like go_router or auto_route
Route<dynamic> router(RouteSettings settings) {
  switch (settings.name) {
    case Routes.kInitialPage:
      return MaterialPageRoute(
        builder: (context) => const InitialPage(),
      );
      case Routes.kHomePage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case Routes.kSignInPage:
      return MaterialPageRoute(
        builder: (context) => const SignInPage(),
      );
    case Routes.kSignUpPage:
      return MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Text('Placeholder'),
      );
  }
}
