import 'package:get/get.dart';

import '../controllers/qrscaner_controller.dart';

class QrscanerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrscanerController>(
      () => QrscanerController(),
    );
  }
}
