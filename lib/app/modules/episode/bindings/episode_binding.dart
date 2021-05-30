import 'package:get/get.dart';

import '../controllers/episode_controller.dart';

class EpisodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EpisodeController>(
      () => EpisodeController(),
    );
  }
}
