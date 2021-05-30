import 'package:cuba_pod/app/data/models/episode_model.dart';
import 'package:cuba_pod/app/data/payloads/episode_by_podcast_query.dart';
import 'package:cuba_pod/app/environment.dart';
import 'package:get/get_connect.dart';

class EpisodeProvider extends GetConnect {
  final Environment environment;

  EpisodeProvider({
    required this.environment,
  });

  @override
  void onInit() {
    httpClient.baseUrl = environment.apiUrl;
  }

  Future<List<EpisodeModel>?> getEpidoseByPodcast(String podcastSlug) async {
    final response = await post(
      '/',
      {
        'query': EpisodeByPodcastQuery(
          podcastSlug: podcastSlug,
        ).payload,
      },
    );

    if (response.statusCode == 200) {
      final episodes = response.body['data']['podcast']['episodes']['objects']
          as List<dynamic>;

      return episodes.map((e) => EpisodeModel.fromJson(e)).toList();
    }

    print(response.statusCode);
    print(response.body);
  }
}
