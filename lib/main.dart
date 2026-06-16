import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_appointment/pages/splash_screen.dart';

void main() {
  runApp(const SmartAppointmentApp());
}

class SmartAppointmentApp extends StatefulWidget {
  const SmartAppointmentApp({super.key});

  @override
  State<SmartAppointmentApp> createState() => _SmartAppointmentAppState();
}

class _SmartAppointmentAppState extends State<SmartAppointmentApp> {
    ThemeMode themeMode =
      ThemeMode.light;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();

  final isDark =
      prefs.getBool('isDarkMode') ?? false;
 
  setState(() {
    themeMode =
        isDark ? ThemeMode.dark : ThemeMode.light;
        
  });
}
Future<void> toggleTheme() async {
  final prefs = await SharedPreferences.getInstance();

  final isDark =
      themeMode == ThemeMode.dark;

  await prefs.setBool(
    'isDarkMode',
    !isDark,
  );

  setState(() {
    themeMode =
        isDark ? ThemeMode.light : ThemeMode.dark;
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Appointment',
      themeMode: themeMode,

theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
  ),
  useMaterial3: true,
),

darkTheme: ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
),
  home: SplashScreen(
  onToggleTheme: toggleTheme,
  isDark: themeMode == ThemeMode.dark,
),
    );
  }
}