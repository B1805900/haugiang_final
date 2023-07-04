import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appinfo_controller.dart';

class AppinfoView extends GetView<AppinfoController> {
  const AppinfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin ứng dụng'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Đang cập nhật dữ liệu!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
