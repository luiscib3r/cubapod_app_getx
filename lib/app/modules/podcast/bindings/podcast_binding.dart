import 'package:cuba_pod/app/data/providers/episode_provider.dart';
import 'package:get/get.dart';

import '../controllers/podcast_controller.dart';

class PodcastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EpisodeProvider>(
      () => EpisodeProvider(
        environment: Get.find(),
      ),
    );

    Get.lazyPut<PodcastController>(
      () => PodcastController(
        episodeProvider: Get.find(),
      ),
    );
  }
}
