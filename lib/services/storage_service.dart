import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/booking_model.dart';

class StorageService {
  static const String bookingsKey = 'bookings';
static const String themeKey = 'theme_mode';
  static Future<void> saveBooking(
    BookingModel booking,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final existingBookings =
        prefs.getStringList(bookingsKey) ?? [];

    existingBookings.add(
      jsonEncode(booking.toJson()),
    );

    await prefs.setStringList(
      bookingsKey,
      existingBookings,
    );
  }

  static Future<List<BookingModel>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();

    final bookingsData =
        prefs.getStringList(bookingsKey) ?? [];

    return bookingsData.map((item) {
      return BookingModel.fromJson(
        jsonDecode(item),
      );
    }).toList();
  }

  static Future<void> clearBookings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(bookingsKey);
  }

  static Future<void> deleteBooking(
    String bookingId,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final bookings =
        prefs.getStringList(bookingsKey) ?? [];

    bookings.removeWhere((item) {
      final booking =
          BookingModel.fromJson(
            jsonDecode(item),
          );

      return booking.id == bookingId;
    });

    await prefs.setStringList(
      bookingsKey,
      bookings,
    );
  }
  static Future<bool> isSlotBooked({
    required String providerId,
    required DateTime date,
    required String time,
  }) async {
    final bookings = await getBookings();

    return bookings.any((booking) {
      return booking.providerId == providerId &&
          booking.date.year == date.year &&
          booking.date.month == date.month &&
          booking.date.day == date.day &&
          booking.time == time;
    });
  }
  static Future<void> saveTheme(
  bool isDark,
) async {
  final prefs =
      await SharedPreferences.getInstance();

  await prefs.setBool(
    themeKey,
    isDark,
  );
}
static Future<bool> getTheme() async {
  final prefs =
      await SharedPreferences.getInstance();

  return prefs.getBool(themeKey) ?? false;
}
}