import 'package:audioplayers/audioplayers.dart';
import 'package:cuba_pod/app/data/models/episode_model.dart';
import 'package:cuba_pod/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpisodeController extends GetxController {
  final scrollControllerTitle = ScrollController();

  final EpisodeModel episode = Get.arguments['episode'];

  final _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double v) => _progress.value = v;

  final _hiddenSummary = false.obs;
  bool get hiddenSummary => _hiddenSummary.value;
  set hiddenSummary(bool v) => _hiddenSummary.value = v;

  final AudioPlayer player = AudioPlayer();

  final _duration = Duration(milliseconds: 0).obs;
  Duration get duration => _duration.value;
  set duration(Duration v) => _duration.value = v;

  final _actualDuration = Duration(milliseconds: 0).obs;
  Duration get actualDuration => _actualDuration.value;
  set actualDuration(Duration v) => _actualDuration.value = v;

  String get actualTime => formatDuration(actualDuration);

  String get totalTime => formatDuration(duration);

  @override
  void onInit() {
    super.onInit();

    loadAudio();
  }

  @override
  onClose() {
    player.stop();
    player.dispose();

    super.onClose();
  }

  loadAudio() async {
    player.onDurationChanged.listen((Duration d) {
      duration = d;
      update();
    });

    player.onAudioPositionChanged.listen((Duration d) {
      actualDuration = d;
      update();
    });

    await player.setUrl(episode.enclosure);
    await player.setReleaseMode(ReleaseMode.STOP);
  }

  bool get playing => player.state == PlayerState.PLAYING;
  bool get stopped =>
      player.state == PlayerState.STOPPED ||
      player.state == PlayerState.COMPLETED;
  bool get paused => player.state == PlayerState.PAUSED;
}
