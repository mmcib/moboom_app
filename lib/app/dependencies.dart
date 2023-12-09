import 'package:get_it/get_it.dart';
import 'package:moboom_app/core/dependencies.dart' as core;
import 'package:moboom_app/features/comments/dependencies.dart' as comments;
import 'package:moboom_app/features/photos/dependencies.dart' as photos;
import 'package:moboom_app/features/auth/dependencies.dart' as auth;

Future<void> setupDependencies(
  GetIt sl, {
  required String moboomApiUrl,
}) async {
  await core.setupDependencies(sl, moboomApiUrl: moboomApiUrl);
  await comments.setupDependencies(sl);
  await photos.setupDependencies(sl);
  await auth.setupDependencies(sl);
}
