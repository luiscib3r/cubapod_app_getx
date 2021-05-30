import 'package:cuba_pod/app/data/models/podcast_model.dart';
import 'package:cuba_pod/app/data/payloads/podcast_by_category_query.dart';
import 'package:cuba_pod/app/environment.dart';
import 'package:get/get_connect.dart';

class ProdcastProvider extends GetConnect {
  final Environment environment;

  ProdcastProvider({
    required this.environment,
  });

  @override
  void onInit() {
    httpClient.baseUrl = environment.apiUrl;
  }

  Future<List<PodcastModel>?> getPodcastByCategory(String categorySlug) async {
    final response = await post(
      '/',
      {
        'query': PodcastByCategoryQuery(
          categorySlug: categorySlug,
        ).payload,
      },
    );

    if (response.statusCode == 200) {
      final podcasts = response.body['data']['podcasts'] as List<dynamic>;

      return podcasts.map((e) => PodcastModel.fromJson(e)).toList();
    }

    print(response.statusCode);
    print(response.body);
  }
}
