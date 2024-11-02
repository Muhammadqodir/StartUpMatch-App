import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/auth_page/auth_page.dart';
import 'package:startupmatch/pages/main_page/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double gradientRadius = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
  }

  void loading() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      gradientRadius = 2;
    });
    await Future.delayed(const Duration(milliseconds: 900));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 900),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, 0),
            radius: gradientRadius,
            colors: const [
              Color(0xFF0141A2),
              Color(0xFF012B6F),
            ],
            stops: const [0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Image.asset(
              "assets/icon_white.png",
              width: 170,
            ),
          ),
        ),
      ),
    );
  }
}
