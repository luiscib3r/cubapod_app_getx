import 'package:cuba_pod/app/data/models/episode_model.dart';
import 'package:cuba_pod/app/data/models/podcast_model.dart';
import 'package:cuba_pod/app/data/providers/episode_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PodcastController extends GetxController {
  final PodcastModel podcast = Get.arguments['podcast'];
  final scrollController = ScrollController();

  final EpisodeProvider episodeProvider;

  PodcastController({
    required this.episodeProvider,
  });

  final _heart = false.obs;
  bool get heart => _heart.value;
  set heart(bool v) => _heart.value = v;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  final _episodes = RxList<EpisodeModel>();
  List<EpisodeModel> get episodes => _episodes;
  set episodes(List<EpisodeModel> v) => _episodes.value = v;

  Future<void> loadData() async {
    final result = await episodeProvider.getEpidoseByPodcast(podcast.slug);

    if (result != null) {
      episodes = result;
    }
  }
}
