import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/booking_model.dart';

class PdfService {
  static Future<void> exportBookings(
    List<BookingModel> bookings,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Smart Appointment',
            ),
          ),

          pw.SizedBox(height: 20),

          ...bookings.map(
            (booking) => pw.Container(
              margin: const pw.EdgeInsets.only(
                bottom: 10,
              ),
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                crossAxisAlignment:
                    pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Client: ${booking.customerName}',
                  ),
                  pw.Text(
                    'Provider: ${booking.providerName}',
                  ),
                  pw.Text(
                    'Date: ${booking.date.day}/${booking.date.month}/${booking.date.year}',
                  ),
                  pw.Text(
                    'Time: ${booking.time}',
                  ),
                  pw.Text(
                    'Phone: ${booking.phone}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async =>
          pdf.save(),
    );
  }
}