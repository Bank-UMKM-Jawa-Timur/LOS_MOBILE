import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final primaryColor = PdfColor.fromHex('#EE2649');

secondHeaderDataPengajuan() {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    columnWidths: {
      0: pw.FlexColumnWidth(1.5),
      1: pw.FlexColumnWidth(2.5),
      2: pw.FlexColumnWidth(1.5),
      3: pw.FlexColumnWidth(1.5),
      4: pw.FlexColumnWidth(1.5),
      5: pw.FlexColumnWidth(1.5),
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
                  "Proses",
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
