import 'package:cuba_pod/app/utils/utils.dart';

class PodcastModel {
  final String title;
  final String author;
  final String slug;
  final int episodesCount;
  final String image;
  final String summary;

  PodcastModel({
    required this.title,
    required this.author,
    required this.slug,
    required this.episodesCount,
    required this.image,
    required this.summary,
  });

  PodcastModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        author = json['author'] ?? '',
        slug = json['slug'] ?? '',
        episodesCount = json['episodesCount'] ?? 0,
        image = json['image'] ?? '',
        summary = removeAllHtmlTags(json['summary'] ?? '');
}
