import 'package:do_it/Pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Center(
          child: RichText(
              text: const TextSpan(
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "Do.",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "It",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }
}
