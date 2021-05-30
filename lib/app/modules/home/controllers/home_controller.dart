import 'package:cuba_pod/app/data/models/category_model.dart';
import 'package:cuba_pod/app/data/models/podcast_model.dart';
import 'package:cuba_pod/app/data/providers/category_provider.dart';
import 'package:cuba_pod/app/data/providers/podcats_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CategoryProvider categoryProvider;
  final ProdcastProvider prodcastProvider;

  HomeController({
    required this.categoryProvider,
    required this.prodcastProvider,
  });

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  final _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool v) => _loading.value = v;

  final _categories = <CategoryModel>[].obs;
  List<CategoryModel> get categories => _categories;
  set categories(List<CategoryModel> v) => _categories.value = v;

  final _activeCategory = 0.obs;
  int get activeCategory => _activeCategory.value;
  set activeCategory(int v) {
    _activeCategory.value = v;
    loadPodcasts();
  }

  Future<void> loadData() async {
    loading = true;
    final result = await categoryProvider.getCategories();

    if (result != null) {
      categories = result;
    }

    loading = false;

    activeCategory = 0;
  }

  String get categorySlug => categories[activeCategory].slug;

  final _podcasts = RxMap<String, List<PodcastModel>>();
  List<PodcastModel>? get podcasts => _podcasts[categorySlug];
  set podcasts(List<PodcastModel>? v) {
    if (v != null) {
      _podcasts[categorySlug] = v;
    }
  }

  loadPodcasts() async {
    if (podcasts == null) {
      podcasts = await prodcastProvider.getPodcastByCategory(categorySlug);
    }
  }
}
