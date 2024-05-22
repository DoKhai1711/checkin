import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:untitled/view/pay/pay_page.dart';

class ScanQRWidget extends StatefulWidget {
  const ScanQRWidget({Key? key}) : super(key: key);

  @override
  State<ScanQRWidget> createState() => _ScanQRWidgetState();
}

class _ScanQRWidgetState extends State<ScanQRWidget> {
  QRViewController? controller;
  String result = "";

  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Quét mã",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.green.shade500,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Result scan: $result",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      // setState(() {
      //   result = event.code!;
      // });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PayPage(
            arguments: PayArguments(
              code: event.code!
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}
