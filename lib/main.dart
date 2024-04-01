import 'package:recipo/auth/auth_services.dart';
import 'package:recipo/screens/login_screen/login_screen.dart';
import 'package:recipo/screens/forget_password_screen/forget_password_screen.dart';
import 'package:recipo/screens/navigation_screen/navigation_screen.dart';
import 'package:recipo/screens/register_screen/register_screen.dart';
import 'package:recipo/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipo',
        themeMode: ThemeMode.light,
        color: Colors.redAccent,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          '/navigationScreen': (context) => const Navigation(),
          '/forgetScreen': (context) => const ForgetScreen(),
          '/registerScreen': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
