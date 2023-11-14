import 'package:flutter/services.dart';
import 'package:moboom_app/app/app.dart';
import 'package:moboom_app/app/dependencies.dart';
import 'package:moboom_app/app/environment_config.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDependencies(
    getIt,
    moboomApiUrl: EnvironmentConfig.host,
  );

  runApp(
    const App(appName: 'Moboom App'),
  );
}
