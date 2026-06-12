import 'package:flutter/material.dart';
import 'package:smart_appointment/services/pdf_service.dart';
import 'package:smart_appointment/services/storage_service.dart';
import '../models/booking_model.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Future<List<BookingModel>> bookingsFuture;

  @override
  void initState() {
    super.initState();
    bookingsFuture = StorageService.getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Bookings"),
        actions: [
          IconButton(
  icon: const Icon(Icons.picture_as_pdf),
  onPressed: () async {
    final bookings =
        await StorageService.getBookings();

    await PdfService.exportBookings(
      bookings,
    );
  },
),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              await StorageService.clearBookings();

              if (!mounted) return;

              setState(() {
                bookingsFuture = StorageService.getBookings();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BookingModel>>(
        future: bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return const Center(
              child: Text(
                "No Bookings Yet",
                style: TextStyle(fontSize: 22),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.event),
                  ),

                  title: Text(
                    booking.customerName,
                  ),

                  subtitle: Text(
                    "${booking.providerName}\n"
                    "${booking.date.day}/${booking.date.month}/${booking.date.year}"
                    " - ${booking.time}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await StorageService.deleteBooking(
                        booking.id,
                      );

                      if (!mounted) return;

                      setState(() {
                        bookingsFuture =
                            StorageService.getBookings();
                      });
                    },
                  ),

                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}