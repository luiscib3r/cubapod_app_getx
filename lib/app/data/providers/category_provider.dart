import 'package:cuba_pod/app/data/models/category_model.dart';
import 'package:cuba_pod/app/data/payloads/categories_query.dart';
import 'package:cuba_pod/app/environment.dart';
import 'package:get/get.dart';

class CategoryProvider extends GetConnect {
  final Environment environment;

  CategoryProvider({
    required this.environment,
  });

  @override
  void onInit() {
    httpClient.baseUrl = environment.apiUrl;
  }

  Future<List<CategoryModel>?> getCategories() async {
    final response = await post(
      '/',
      {
        'query': CategoriesQuery().payload,
      },
    );

    if (response.statusCode == 200) {
      final categories = response.body['data']['categories'] as List<dynamic>;

      return categories.map((e) => CategoryModel.fromJson(e)).toList();
    }

    print(response.statusCode);
    print(response.body);
  }
}
