import 'dart:io';

import 'package:corcon/api/pdf_api.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfIdCartApi {
  static Future<File> generate(context, data) async {
    final pdf = Document();
    final imageJpg = (await rootBundle.load('assets/images/corcon_ogo.png'))
        .buffer
        .asUint8List();
    final personImg = (await rootBundle.load('assets/images/profile.png'))
        .buffer
        .asUint8List();
    final naceImg =
        (await rootBundle.load('assets/images/nace.png')).buffer.asUint8List();
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        build: (context) => [
          Container(
            width: 384,
            height: 576,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  MemoryImage(imageJpg),
                  width: 180,
                ),
                Column(children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image(
                      MemoryImage(personImg),
                      width: 160,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['username'].toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Electro Corr Damp Pvt. Ltd.'),
                ]),
                BarcodeWidget(
                  color: PdfColor.fromHex('#000000'),
                  data: data.toString(),
                  barcode: Barcode.qrCode(),
                  width: 120,
                  height: 120,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return PdfApi.saveDocument(fileName: 'ID_CARD.pdf', pdf: pdf);
  }
}
