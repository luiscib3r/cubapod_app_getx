class PodcastByCategoryQuery {
  final String categorySlug;

  String get payload => """
  query {
    podcasts(categorySlug: "$categorySlug") {
      title
      author
      slug
      episodesCount
      image
      summary
    }
  }
  """;

  PodcastByCategoryQuery({
    required this.categorySlug,
  });
}
