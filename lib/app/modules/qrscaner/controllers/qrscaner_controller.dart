import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constant.dart';

class QrscanerController extends GetxController {
  //TODO: Implement QrscanerController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void showDialogMessagenew(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Đóng',
              style: TextStyle(color: primaryColor, fontSize: 18),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
