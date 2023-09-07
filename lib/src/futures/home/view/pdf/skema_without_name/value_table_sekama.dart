import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final primaryColor = PdfColor.fromHex('#EE2649');

valueTableSkemaWithoutName(
  context,
  String kode,
  String cabang,
  String pkpj,
  String kkb,
  String umroh,
  String prokesra,
  String kusuma,
  int total,
) {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    columnWidths: {
      0: const pw.FlexColumnWidth(1.5),
      1: const pw.FlexColumnWidth(2.5),
      2: const pw.FlexColumnWidth(1.5),
      3: const pw.FlexColumnWidth(1.5),
      4: const pw.FlexColumnWidth(1.5),
      5: const pw.FlexColumnWidth(1.5),
      6: const pw.FlexColumnWidth(1.5),
      7: const pw.FlexColumnWidth(1.5),
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
                  cabang,
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
                  pkpj,
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
                  kkb,
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
                  umroh,
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
                  prokesra,
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
                  kusuma,
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
                  total.toString(),
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
