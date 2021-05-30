import 'package:get/get.dart';

import 'package:cuba_pod/app/modules/episode/bindings/episode_binding.dart';
import 'package:cuba_pod/app/modules/episode/views/episode_view.dart';
import 'package:cuba_pod/app/modules/home/bindings/home_binding.dart';
import 'package:cuba_pod/app/modules/home/views/home_view.dart';
import 'package:cuba_pod/app/modules/podcast/bindings/podcast_binding.dart';
import 'package:cuba_pod/app/modules/podcast/views/podcast_view.dart';
import 'package:cuba_pod/app/modules/root/bindings/root_binding.dart';
import 'package:cuba_pod/app/modules/root/views/root_view.dart';
import 'package:cuba_pod/app/modules/settings/bindings/settings_binding.dart';
import 'package:cuba_pod/app/modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.PODCAST,
      page: () => PodcastView(),
      binding: PodcastBinding(),
    ),
    GetPage(
      name: _Paths.EPISODE,
      page: () => EpisodeView(),
      binding: EpisodeBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
