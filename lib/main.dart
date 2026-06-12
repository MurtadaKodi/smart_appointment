import 'package:flutter/material.dart';
import 'package:smart_appointment/services/storage_service.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SmartAppointmentApp());
}

class SmartAppointmentApp extends StatefulWidget {
  const SmartAppointmentApp({super.key});

  @override
  State<SmartAppointmentApp> createState() => _SmartAppointmentAppState();
}

class _SmartAppointmentAppState extends State<SmartAppointmentApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final isDark =
        await StorageService.getTheme();

    setState(() {
      themeMode =
          isDark
              ? ThemeMode.dark
              : ThemeMode.light;
    });
  }

  void toggleTheme() async {
    final isDark =
        themeMode == ThemeMode.light;

    setState(() {
      themeMode =
          isDark
              ? ThemeMode.dark
              : ThemeMode.light;
    });

    await StorageService.saveTheme(
      isDark,
    );
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
      home: HomePage(
  onToggleTheme: toggleTheme,
  isDark:
      themeMode == ThemeMode.dark,
),
    );
  }
}