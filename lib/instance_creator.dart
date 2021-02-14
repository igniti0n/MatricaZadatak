import 'package:MatricaZadatak/routing/router.dart';
import 'package:get_it/get_it.dart';

GetIt instanceCreator;

void initInstances() {
  instanceCreator = GetIt.instance;
  instanceCreator.registerLazySingleton(() => AppRouter());
}
