import 'package:get_it/get_it.dart';
import 'package:moboom_app/core/dependencies.dart' as core;

Future<void> setupDependencies(GetIt sl, {required String moboomApiUrl}) async {
  await core.setupDependencies(sl, moboomApiUrl: moboomApiUrl);
}
