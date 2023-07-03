import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/testqr_controller.dart';

class TestqrView extends GetView<TestqrController> {
  const TestqrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestqrView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TestqrView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
