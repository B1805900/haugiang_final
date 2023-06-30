import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apidemo_controller.dart';

class ApidemoView extends GetView<ApidemoController> {
  const ApidemoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
      body: const Text("Helo"),

    );
  }


}
