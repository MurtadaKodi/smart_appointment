import 'package:flutter/material.dart';
import '../data/providers.dart';
import '../widgets/booking_form.dart';

class BookingPage extends StatelessWidget {
  final ServiceProvider provider;

  const BookingPage({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: isMobile
            ? Column(
                children: [
                  _providerInfo(provider),
                  const SizedBox(height: 20),
                  BookingForm(provider: provider),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: _providerInfo(provider),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    flex: 6,
                    child: BookingForm(provider: provider),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _providerInfo(ServiceProvider provider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(provider.image),
            ),
            const SizedBox(height: 20),
            Text(
              provider.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              provider.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              provider.description,
              textAlign: TextAlign.center,
            ),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(provider.email),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(provider.phone),
            ),
          ],
        ),
      ),
    );
  }
}