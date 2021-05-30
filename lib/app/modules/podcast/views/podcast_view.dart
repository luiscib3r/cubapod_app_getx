import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuba_pod/app/data/models/podcast_model.dart';
import 'package:cuba_pod/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';

import '../controllers/podcast_controller.dart';

class PodcastView extends GetView<PodcastController> {
  final PodcastModel podcast = Get.arguments['podcast'];

  @override
  Widget build(BuildContext context) => view;

  Widget get view => Scaffold(
        backgroundColor: Get.theme.primaryColor,
        body: body,
      );

  Widget get body => SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                podcastCover,
                SizedBox(
                  height: 30,
                ),
                titleWidget,
                SizedBox(
                  height: 15,
                ),
                descriptionWidget,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '${podcast.episodesCount} episodio${podcast.episodesCount > 1 ? "s" : ""}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                episodesWidget,
              ],
            ),
            controllButtons,
          ],
        ),
      );

  Widget get podcastCover => CachedNetworkImage(
        imageUrl: podcast.image,
        placeholder: (context, url) => Container(
          width: Get.width,
          height: 220,
          decoration: BoxDecoration(
            color: Get.theme.accentColor,
          ),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: Get.width,
          height: 220,
          decoration: BoxDecoration(
            color: Get.theme.accentColor,
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
          width: Get.width,
          height: 220,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget get controllButtons => SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: Get.back,
            ),
            IconButton(
              icon: Icon(
                FeatherIcons.moreVertical,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );

  Widget get titleWidget => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width / 1.5,
              child: Text(
                podcast.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  controller.heart = !controller.heart;
                },
                icon: Obx(
                  () => controller.heart
                      ? Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.white,
                        )
                      : Icon(
                          CupertinoIcons.heart,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget get descriptionWidget => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: Get.height / 5,
          child: Scrollbar(
            controller: controller.scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Text(podcast.summary),
            ),
          ),
        ),
      );

  Widget get episodesWidget => Obx(
        () => controller.episodes.length > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.episodes.length,
                  (index) {
                    final episode = controller.episodes[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                        bottom: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.EPISODE,
                            arguments: {
                              'podcast': podcast,
                              'episode': episode,
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: (Get.width - 66) * 0.90,
                              height: 50,
                              child: Center(
                                child: Text(
                                  '${index + 1} ${episode.title}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              width: (Get.width - 66) * 0.10,
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Get.theme.accentColor,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      );
}
