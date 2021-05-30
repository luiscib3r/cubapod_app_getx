import 'package:cuba_pod/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';


import 'package:get/get.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) => view;

  Widget get view => Scaffold(
        backgroundColor: Get.theme.primaryColor,
        body: body,
        bottomNavigationBar: footer,
      );

  Widget get body => Obx(
        () => IndexedStack(
          index: controller.activeTab,
          children: [
            HomeView(),
            Center(
              child: Text(
                'Favorites',
                style: Get.textTheme.headline3,
              ),
            ),
            Center(
              child: Text(
                'Search',
                style: Get.textTheme.headline3,
              ),
            ),
            Center(
              child: Text(
                'Settings',
                style: Get.textTheme.headline3,
              ),
            ),
          ],
        ),
      );

  Widget get footer {
    final items = [
      FeatherIcons.home,
      FeatherIcons.heart,
      FeatherIcons.search,
      FeatherIcons.settings,
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            items.length,
            (index) => IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Obx(
                () => Icon(
                  items[index],
                  color: controller.activeTab == index
                      ? Get.theme.accentColor
                      : Get.iconColor,
                ),
              ),
              onPressed: () {
                controller.activeTab = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}
