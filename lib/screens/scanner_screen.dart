import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrKey = GlobalKey(debugLabel: "OK");
  QRViewController? controller;
  Barcode? result;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Scanner"),
      // ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[buildQRView(context)],
      ),
    );
  }

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(),
      );

  void onQRViewCreated(QRViewController controller) {
    int count = 0;
    setState(() {
      this.controller = controller;
      controller.scannedDataStream.listen((event) {
        result = event;
        if (count < 1) {
          final snackBar = SnackBar(
            content: Text(result!.code),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          count += 1;
          Navigator.of(context).pop();
        }
      });
    });
  }
}
