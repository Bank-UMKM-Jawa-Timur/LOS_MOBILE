import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

grandDataPengajuan(
  int totalDisetujui,
  int totalDitolak,
  int totalDiproses,
  int totalSemua,
) {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    columnWidths: {
      0: const pw.FlexColumnWidth(4),
      1: const pw.FlexColumnWidth(1.5),
      2: const pw.FlexColumnWidth(1.5),
      3: const pw.FlexColumnWidth(1.5),
      4: const pw.FlexColumnWidth(1.5),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Grand Total",
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "$totalDisetujui",
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "$totalDitolak",
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "$totalDiproses",
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ),
          pw.Container(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "$totalSemua",
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 8,
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
