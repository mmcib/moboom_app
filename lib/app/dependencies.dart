import 'package:get_it/get_it.dart';
import 'package:moboom_app/core/dependencies.dart' as core;
import 'package:moboom_app/features/comments/dependencies.dart' as comments;

Future<void> setupDependencies(
  GetIt sl, {
  required String moboomApiUrl,
}) async {
  await core.setupDependencies(sl, moboomApiUrl: moboomApiUrl);
  await comments.setupDependencies(sl);
}
