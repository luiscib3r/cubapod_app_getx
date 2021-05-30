import 'package:cuba_pod/app/utils/utils.dart';

class EpisodeModel {
  final String title;
  final String summary;
  final String slug;
  final String image;
  final String enclosure;
  final String link;

  EpisodeModel({
    required this.title,
    required this.summary,
    required this.slug,
    required this.image,
    required this.enclosure,
    required this.link,
  });

  EpisodeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        summary = removeAllHtmlTags(json['summary'] ?? ''),
        slug = json['slug'] ?? '',
        image = json['image'] ?? '',
        enclosure = json['enclosure'] ?? '',
        link = json['link'] ?? '';
}
