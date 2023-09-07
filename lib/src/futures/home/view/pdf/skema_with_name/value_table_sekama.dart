import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final primaryColor = PdfColor.fromHex('#EE2649');

valueTableSkemaWithName(
  context,
  String kode,
  String cabang,
  String disetujui,
  String ditolak,
  String pincab,
  String pbp,
  String pbo,
  String penyelia,
  String staf,
  int total,
) {
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
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  kode,
                  style: pw.TextStyle(
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
                  cabang,
                  style: pw.TextStyle(
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
                  disetujui.toString(),
                  style: pw.TextStyle(
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
                  ditolak.toString(),
                  style: pw.TextStyle(
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
                  pincab.toString(),
                  style: pw.TextStyle(
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
                  pbp.toString(),
                  style: pw.TextStyle(
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
                  pbo.toString(),
                  style: pw.TextStyle(
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
                  penyelia.toString(),
                  style: pw.TextStyle(
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
                  staf.toString(),
                  style: pw.TextStyle(
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
                  total.toString(),
                  style: pw.TextStyle(
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
