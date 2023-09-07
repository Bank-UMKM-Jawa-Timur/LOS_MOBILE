import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final primaryColor = PdfColor.fromHex('#EE2649');

valueTablePosisiPengajuan(
  context,
  String kode,
  String cabang,
  int disetujui,
  int ditolak,
  int pincab,
  int pbp,
  int pbo,
  int penyelia,
  int staf,
  int total,
) {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    columnWidths: {
      0: pw.FlexColumnWidth(1.3),
      1: pw.FlexColumnWidth(2.5),
      2: pw.FlexColumnWidth(1.5),
      3: pw.FlexColumnWidth(1.2),
      4: pw.FlexColumnWidth(1.2),
      5: pw.FlexColumnWidth(1),
      6: pw.FlexColumnWidth(1),
      7: pw.FlexColumnWidth(1.5),
      8: pw.FlexColumnWidth(1),
      9: pw.FlexColumnWidth(1.1),
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
