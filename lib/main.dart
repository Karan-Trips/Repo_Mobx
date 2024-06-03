import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'model/Data/UserMobx/user_mobx.dart';
import 'pages/ui/home_screen.dart';
import 'pages/userLogin/register_user.dart';
import 'pages/userLogin/login_user.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

setup() {
  GetIt.instance.registerLazySingleton(() => UserStore());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  final dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
    request: true,
    maxWidth: 100,
  ));
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterUser(),
        '/login': (context) => const LoginUser(),
        '/home': (context) => const UserHome(),
      },
    );
  }
}
