import 'package:flutter/material.dart';
import 'package:smart_appointment/pages/admin_login_page.dart';
import 'package:smart_appointment/pages/booking_page.dart';
import '../data/providers.dart';
import '../widgets/service_card.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;
  const HomePage({super.key, required this.onToggleTheme, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;

    if (width > 1200) {
      crossAxisCount = 3;
    } else if (width > 700) {
      crossAxisCount = 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Appointment"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: providers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final provider = providers[index];

            return ServiceCard(
              name: provider.name,
              image: provider.image,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return BookingPage(provider: provider);
                    },
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
