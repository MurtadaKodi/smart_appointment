import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/booking_model.dart';

class PdfService {
  static Future<void> exportBookings(List<BookingModel> bookings) async {
    pw.MemoryImage? logoImage;
    try {
      final imageData = await rootBundle.load('assets/images/logo.png');
      logoImage = pw.MemoryImage(imageData.buffer.asUint8List());
    } catch (_) {
      logoImage = null;
    }

    final arabicFonts = await _loadArabicFonts();

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: arabicFonts.$1, bold: arabicFonts.$2),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.ltr,

        build: (context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              if (logoImage != null) pw.Image(logoImage, width: 55, height: 55),

              pw.SizedBox(width: 15),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'SMART APPOINTMENT',
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),

                  pw.SizedBox(height: 4),

                  pw.Text('Appointments Report', style: const pw.TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 12),

                pw.Align(
            alignment: pw.Alignment.centerRight,
            child:  pw.Text(
            'إجمالي الحجوزات: ${bookings.length}',
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            textDirection: pw.TextDirection.rtl,
            textAlign: pw.TextAlign.center,
          
          ),
          ),

         

          pw.SizedBox(height: 10),

          pw.Divider(),

          pw.SizedBox(height: 12),
          pw.SizedBox(height: 20),

          ...bookings.asMap().entries.map<pw.Widget>((entry) {
            final index = entry.key;
            final booking = entry.value;
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 15),

              padding: const pw.EdgeInsets.all(12),

              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                borderRadius: pw.BorderRadius.circular(8),
              ),

              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,

                children: [
                  pw.Text(
                    'الحجز رقم ${index + 1}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.right,
                  ),

                  pw.Divider(),

                  pw.SizedBox(height: 10),

                  pw.Text(
                    'العميل: ${booking.customerName}',
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.right,
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'مقدم الخدمة: ${booking.providerName}',
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.right,
                  ),
                  pw.SizedBox(height: 5),

                  pw.Text(
                    'التاريخ: ${booking.date.day}/${booking.date.month}/${booking.date.year}',
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.right,
                  ),
                  pw.SizedBox(height: 5),

                  pw.Text(
                    'الوقت: ${booking.time}',
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.right,
                  ),
                  pw.SizedBox(height: 5),

                  pw.Text(
                    'الهاتف: ${booking.phone}',
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.right,
                  ),
                ],
              ),
            );
          }),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
             
              pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Smart Appointment ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              textDirection: pw.TextDirection.rtl,
            ),
          ), 
               pw.Text(
                'تم الإنشاء بواسطة ',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey),
                textDirection: pw.TextDirection.rtl,
              ), 
            ],
          ),
          
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  static Future<(pw.Font, pw.Font)> _loadArabicFonts() async {
    try {
      final regularData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
      final boldData = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
      return (pw.Font.ttf(regularData), pw.Font.ttf(boldData));
    } catch (_) {
      final regular = await PdfGoogleFonts.cairoRegular();
      final bold = await PdfGoogleFonts.cairoBold();
      return (regular, bold);
    }
  }
}
