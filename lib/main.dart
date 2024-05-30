import 'package:flutter/material.dart';

import 'pages/ui/home_screen.dart';
import 'pages/userLogin/register_user.dart';
import 'pages/userLogin/login_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
