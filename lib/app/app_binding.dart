import 'package:cuba_pod/app/environment.dart';
import 'package:cuba_pod/app/theme/theme_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBinding extends Bindings {
  final SharedPreferences storage;

  AppBinding({
    required this.storage,
  });

  @override
  void dependencies() {
    Get.put<Environment>(
      Environment.production(),
      permanent: true,
    );

    Get.put<SharedPreferences>(
      storage,
      permanent: true,
    );

    Get.put<ThemeController>(
      ThemeController(
        storage: Get.find(),
      ),
      permanent: true,
    );
  }
}
