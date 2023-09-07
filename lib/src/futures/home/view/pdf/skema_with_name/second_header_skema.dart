import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final primaryColor = PdfColor.fromHex('#EE2649');

secondHeaderSkemaWithName() {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    columnWidths: {
      0: const pw.FlexColumnWidth(1.3),
      1: const pw.FlexColumnWidth(2.5),
      2: const pw.FlexColumnWidth(1.5),
      3: const pw.FlexColumnWidth(1.2),
      4: const pw.FlexColumnWidth(1.2),
      5: const pw.FlexColumnWidth(1),
      6: const pw.FlexColumnWidth(1),
      7: const pw.FlexColumnWidth(1.5),
      8: const pw.FlexColumnWidth(1),
      9: const pw.FlexColumnWidth(1.1),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Kode",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Cabang",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Disetujui",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Ditolak",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Pincab",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "PBP",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "PBO",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Penyelia",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Staff",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Total",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
