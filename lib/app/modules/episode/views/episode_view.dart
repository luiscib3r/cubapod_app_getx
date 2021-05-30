import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuba_pod/app/data/models/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';

import '../controllers/episode_controller.dart';

class EpisodeView extends GetView<EpisodeController> {
  final EpisodeModel episode = Get.arguments['episode'];

  @override
  Widget build(BuildContext context) => view;

  Widget get view => Scaffold(
        backgroundColor: Get.theme.primaryColor,
        appBar: appBar,
        body: body,
      );

  AppBar get appBar => AppBar(
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.hiddenSummary = !controller.hiddenSummary;
            },
            icon: Icon(
              FeatherIcons.moreVertical,
            ),
          )
        ],
      );

  Widget get body => SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                episodeImage,
              ],
            ),
            SizedBox(
              height: 15,
            ),
            titleWidget,
            SizedBox(
              height: 15,
            ),
            progressWidget,
            SizedBox(
              height: 15,
            ),
            timerWidget,
            SizedBox(
              height: 15,
            ),
            playerWidget,
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );

  Widget get episodeImage => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: CachedNetworkImage(
          imageUrl: episode.image,
          placeholder: (context, url) => Container(
            width: Get.width - 80,
            height: Get.width - 80,
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: Get.width - 80,
            height: Get.width - 80,
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                Icons.error,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
          imageBuilder: (context, imageProvider) => Container(
            width: Get.width - 80,
            height: Get.width - 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Widget get titleWidget => Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Obx(
          () => controller.hiddenSummary
              ? titleWithDescription
              : Container(
                  width: Get.width - 40,
                  child: Text(
                    episode.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        ),
      );

  Widget get titleWithDescription => Container(
        width: Get.width - 40,
        height: 200,
        child: Row(
          children: [
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                controller: controller.scrollControllerTitle,
                child: ListView(
                  controller: controller.scrollControllerTitle,
                  children: [
                    Text(
                      episode.title,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        episode.summary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget get progressWidget => Obx(
        () => Slider(
          min: 0,
          max: controller.duration.inMicroseconds.toDouble(),
          value: controller.actualDuration.inMicroseconds.toDouble(),
          onChanged: (value) async {
            final d = Duration(microseconds: value.toInt());

            await controller.player.seek(d);

            controller.update();
          },
        ),
      );

  Widget get timerWidget => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.actualTime,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                controller.totalTime,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get playerWidget => Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                FeatherIcons.skipBack,
              ),
              onPressed: () {
                controller.player.seek(
                  controller.actualDuration -
                      Duration(
                        seconds: 3,
                      ),
                );
              },
            ),
            IconButton(
              iconSize: 64,
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Get.theme.accentColor,
                ),
                child: Center(child: playButton),
              ),
              onPressed: () async {
                if (controller.duration.inSeconds == 0) {
                  return;
                }
                
                if (controller.playing) {
                  await controller.player.pause();
                  controller.update();
                  return;
                }

                if (controller.paused) {
                  await controller.player.resume();
                  controller.update();
                  return;
                }

                if (controller.stopped) {
                  await controller.player.resume();
                  controller.update();
                  return;
                }
              },
            ),
            IconButton(
              icon: Icon(
                FeatherIcons.skipForward,
              ),
              onPressed: () {
                controller.player.seek(
                  controller.actualDuration +
                      Duration(
                        seconds: 3,
                      ),
                );
              },
            ),
          ],
        ),
      );

  Widget get playButton => GetBuilder<EpisodeController>(
        builder: (_) {
          if (controller.duration.inSeconds == 0) {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            );
          }

          if (controller.playing) {
            return Icon(
              FeatherIcons.pause,
              size: 32,
              color: Colors.white,
            );
          }

          if (controller.stopped || controller.paused) {
            return Icon(
              FeatherIcons.play,
              size: 32,
              color: Colors.white,
            );
          }

          return Icon(
            FeatherIcons.play,
            size: 32,
            color: Colors.white,
          );
        },
      );
}
