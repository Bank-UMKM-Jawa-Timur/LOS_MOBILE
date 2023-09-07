import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final primaryColor = PdfColor.fromHex('#EE2649');

headerMainPosisiPengajuan() {
  return pw.Table(
    border: pw.TableBorder.all(width: 0),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: primaryColor,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Center(
                child: pw.Text(
                  "Posisi Pengajuan",
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
