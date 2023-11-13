import 'package:get_it/get_it.dart';
import 'package:moboom_app/core/data/api/api_client.dart';

Future<void> setupDependencies(
  GetIt getIt, {
  required String moboomApiUrl,
}) async {
  getIt..registerSingleton<ApiClient>(ApiClient(moboomApiUrl));
}
