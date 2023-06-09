import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:samasy_app/pages/home_page.dart';
import 'package:samasy_app/pages/login_page.dart';

import 'package:samasy_app/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // cunado usemos en async en el main debemos de colocar esto

  final authService = AuthServices();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => AuthServices() ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn)
    )
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'samasy app',
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? 'home' : 'login',
      routes: {
        'login':   (context) => const LoginPage(),
        'home':    (context) => const HomePage(),
      },
    );
  }
}