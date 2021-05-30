import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuba_pod/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CubaPod',
                style: Get.textTheme.bodyText1?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(FeatherIcons.list),
            ],
          ),
        ),
      );

  Widget get body => Obx(
        () => controller.loading ? loadingWidget : doneWidget,
      );

  Widget get loadingWidget => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget get doneWidget => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                categoriesWidget,
                SizedBox(
                  height: 20,
                ),
                podcastsWidget,
              ],
            )
          ],
        ),
      );

  Widget get categoriesWidget => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 30,
            top: 20,
          ),
          child: Row(
            children: List.generate(
              controller.categories.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    controller.activeCategory = index;
                  },
                  child: Column(
                    children: [
                      Text(
                        controller.categories[index].name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: controller.activeCategory == index
                              ? Get.theme.accentColor
                              : Get.iconColor,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      controller.activeCategory == index
                          ? Container(
                              width: 10,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Get.theme.accentColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get podcastsWidget => controller.podcasts != null
      ? SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: List.generate(
                controller.podcasts!.length,
                (index) {
                  final podcast = controller.podcasts![index];

                  final podcastImage = CachedNetworkImage(
                    imageUrl: podcast.image,
                    placeholder: (context, url) => Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Get.theme.accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Get.theme.accentColor,
                        borderRadius: BorderRadius.circular(10),
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
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                        color: Get.theme.accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );

                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.PODCAST,
                          arguments: {'podcast': podcast},
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          podcastImage,
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            child: Text(
                              podcast.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Get.iconColor,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: 0.5,
                          ),
                          Container(
                            width: 200,
                            height: Get.height / 4,
                            child: Text(
                              podcast.summary,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            loadingWidget,
          ],
        );
}
