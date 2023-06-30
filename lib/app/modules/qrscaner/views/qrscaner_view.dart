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
        title: const Text('Quét QR Căn Cước Công Dân'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Mở Camera'),
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
      'Hủy', // Văn bản nút hủy
      false, // Chế độ quét liên tục
      ScanMode.QR, // Chế độ quét mã QR
    );

    if (barcodeScanResult != '-1') {
      // Xử lý dữ liệu mã QR đã quét thành công
    //  controller.showDialogMessagenew(barcodeScanResult);
      List<String> values = barcodeScanResult.split("|");

      String idNumber = values[0];
      String phoneNumber = values[1];
      String fullName = values[2];
      String birthDate = values[3];
      String gender = values[4];
      String address = values[5];
      String expiryDate = values[6];

      int birthDay = int.parse(birthDate.substring(0, 2)); // Lấy 2 ký tự đầu tiên
      int birthMonth = int.parse(birthDate.substring(2, 4)); // Lấy 2 ký tự tiếp theo
      int birthYear = int.parse(birthDate.substring(4, 8)); // Lấy 4 ký tự cuối cùng

      // Lấy ngày tháng năm hiện tại
      DateTime currentDate = DateTime.now();
      int currentDay = currentDate.day;
      int currentMonth = currentDate.month;
      int currentYear = currentDate.year;

      // Tính tuổi
      int age = currentYear - birthYear;
      if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay)) {
        age--;
      }
      controller.showDialogMessagenew("${age}");

    } else {
      // Người dùng đã hủy quét mã QR
      // controller.showDialogMessagenew("Scan Erorr");
    }
  }
}
