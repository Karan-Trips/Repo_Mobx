import 'package:get_it/get_it.dart';

import '../../data/UserMobx/user_mobx.dart';

Future<void> setup() async {
  GetIt.instance.registerLazySingleton(() => UserStore());
}