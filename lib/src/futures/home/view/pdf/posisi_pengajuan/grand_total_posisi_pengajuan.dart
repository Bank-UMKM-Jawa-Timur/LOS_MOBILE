import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

grandPosisiPengajuan(
  int totalDisetujui,
  int totalDitolak,
  int totalPincab,
  int totalpbp,
  int totalpbo,
  int totalPenyelia,
  int totalStaf,
  int totalSeluruh,
) {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    columnWidths: {
      0: pw.FlexColumnWidth(3.8),
      1: pw.FlexColumnWidth(1.5),
      2: pw.FlexColumnWidth(1.2),
      3: pw.FlexColumnWidth(1.2),
      4: pw.FlexColumnWidth(1),
      5: pw.FlexColumnWidth(1),
      6: pw.FlexColumnWidth(1.5),
      7: pw.FlexColumnWidth(1),
      8: pw.FlexColumnWidth(1.1),
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
                  "$totalPincab",
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
                  "$totalpbp",
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
                  "$totalpbo",
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
                  "$totalPenyelia",
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
                  "$totalStaf",
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
                  "$totalSeluruh",
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
