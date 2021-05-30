import 'package:get/get.dart';

class RootController extends GetxController {
  // activeTab
  RxInt _activeTab = 0.obs;
  int get activeTab => _activeTab.value;
  set activeTab(int v) => _activeTab.value = v;
}
