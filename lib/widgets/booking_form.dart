import 'package:flutter/material.dart';
import 'package:smart_appointment/models/booking_model.dart';
import 'package:smart_appointment/services/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/providers.dart';

class BookingForm extends StatefulWidget {
  final ServiceProvider provider;

  const BookingForm({super.key, required this.provider});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  List<String> availableSlots = [];
  final List<String> availableTimes = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
  ];
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final notesController = TextEditingController();
  DateTime? selectedDate;
  String? selectedTimeSlot;
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Book Appointment",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder()),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: InputDecoration(labelText: "Notes", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                selectedDate == null
                    ? "Select Date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              initialValue: availableSlots.contains(selectedTimeSlot) ? selectedTimeSlot : null,
              decoration: const InputDecoration(
                labelText: "Time Slot",
                border: OutlineInputBorder(),
              ),
              items: availableSlots.map((time) {
                return DropdownMenuItem(value: time, child: Text(time));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTimeSlot = value;
                });
              },
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        if (isSaving) return;

                        setState(() {
                          isSaving = true;
                        });
                        if (nameController.text.trim().isEmpty ||
                            emailController.text.trim().isEmpty ||
                            phoneController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all required fields")),
                          );
                          setState(() {
                            isSaving = false;
                          });
                          return;
                        }
                        if (selectedDate == null || selectedTimeSlot == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select date and time")),
                          );
                          setState(() {
                            isSaving = false;
                          });
                          return;
                        }

                        final booking = BookingModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          providerId: widget.provider.id,
                          providerName: widget.provider.name,
                          customerName: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
                          notes: notesController.text.trim(),
                          date: selectedDate!,
                          time: selectedTimeSlot!,
                        );
                        final isBooked = await StorageService.isSlotBooked(
                          providerId: widget.provider.id,
                          date: selectedDate!,
                          time: selectedTimeSlot!,
                        );

                        if (isBooked) {
                          isSaving = false;
                          if (!mounted) return;

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("This appointment is already booked")),
                          );

                          return;
                        }
                        await StorageService.saveBooking(booking);
                        await sendWhatsAppMessage(booking);
                        await loadAvailableSlots();
                        final allBookings = await StorageService.getBookings();

                        // ignore: avoid_print
                        print(allBookings.length);

                        if (!mounted) return;

                        // ignore: use_build_context_synchronously
                        await showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),

                              title: const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),

                                  SizedBox(width: 10),

                                  Text("Booking Confirmed"),
                                ],
                              ),

                              content: const Text(
                                "Your appointment has been successfully booked.\n\n"
                                "A notification has been sent to the administrator.",
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                        if (!mounted) return;

                        setState(() {
                          isSaving = false;
                        });

                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        notesController.clear();

                        setState(() {
                          selectedDate = null;
                          selectedTimeSlot = null;
                          availableSlots = [];
                        });
                      },
                child: const Text("Book Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        isSaving = false;
        selectedDate = date;
      });
      await loadAvailableSlots();
    }
  }

  Future<void> loadAvailableSlots() async {
    if (selectedDate == null) return;

    final bookings = await StorageService.getBookings();

    final bookedSlots = bookings
        .where(
          (booking) =>
              booking.providerId == widget.provider.id &&
              booking.date.year == selectedDate!.year &&
              booking.date.month == selectedDate!.month &&
              booking.date.day == selectedDate!.day,
        )
        .map((booking) => booking.time)
        .toList();

    setState(() {
      availableSlots = availableTimes.where((time) => !bookedSlots.contains(time)).toList();
    });
  }

  Future<void> sendWhatsAppMessage(BookingModel booking) async {
    const adminPhone = "97455767001"; // رقم الإدارة

    final message =
        '''
📅 New Appointment

Provider: ${booking.providerName}

Client: ${booking.customerName}

Date:
${booking.date.day}/${booking.date.month}/${booking.date.year}

Time:
${booking.time}

Phone:
${booking.phone}
''';

    final url = 'https://wa.me/$adminPhone?text=${Uri.encodeComponent(message)}';

    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
