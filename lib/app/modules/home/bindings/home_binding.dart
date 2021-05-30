import 'package:cuba_pod/app/data/providers/category_provider.dart';
import 'package:cuba_pod/app/data/providers/podcats_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(
        environment: Get.find(),
      ),
    );

    Get.lazyPut<ProdcastProvider>(
      () => ProdcastProvider(
        environment: Get.find(),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        categoryProvider: Get.find(),
        prodcastProvider: Get.find(),
      ),
    );
  }
}
