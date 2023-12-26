import 'package:bronco_trucking/di/api/api_interface.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<APIProvider>(APIProvider());
}
