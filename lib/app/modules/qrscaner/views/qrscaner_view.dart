import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/qrscaner_controller.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrscanerView extends GetView<QrscanerController> {
  const QrscanerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QrscanerView'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Scan QR Code'),
          onPressed: () {
            scanQRCode(context);
          },
        ),
      ),
    );
  }
    Future<void> scanQRCode(BuildContext context) async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Màu sắc của thanh quét
      'Cancel', // Văn bản nút hủy
      false, // Chế độ quét liên tục
      ScanMode.QR, // Chế độ quét mã QR
    );

    if (barcodeScanResult != '-1') {
      // Xử lý dữ liệu mã QR đã quét thành công
      print(barcodeScanResult);
    } else {
      // Người dùng đã hủy quét mã QR
      print('Scan canceled');
    }
  }
}
