import 'package:get/get.dart';

import '../controllers/appinfo_controller.dart';

class AppinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppinfoController>(
      () => AppinfoController(),
    );
  }
}
