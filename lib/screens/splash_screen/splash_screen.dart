import 'dart:async';
import 'package:recipo/auth/wrapper.dart';
import 'package:recipo/screens/splash_screen/Zig_Zag_Zipper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: const Color.fromRGBO(226, 55, 68, 1.0),
              ),
            ),
          ),
          Positioned(
            top: 40,
            child: ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: const Color.fromRGBO(226, 55, 68, 0.80),
              ),
            ),
          ),
          Positioned(
            top: 80,
            child: ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: const Color.fromRGBO(226, 55, 68, 0.60),
              ),
            ),
          ),
          Center(
              child: Image.asset(
            "assets/images/Logo4Recipo.png",
            width: 500,
            height: 500,
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Wrapper(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Wrapper(),
        ),
      );
    }
  }
}
