import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const SplashScreen({super.key, required this.onToggleTheme, required this.isDark});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    controller.forward();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(onToggleTheme: widget.onToggleTheme, isDark: widget.isDark),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: controller,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset("assets/images/logo.png", width: 120, height: 120),

              const SizedBox(height: 20),

              const Text(
                "SMART APPOINTMENT",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text("Your Time Matters", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
