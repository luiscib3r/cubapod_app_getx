class EpisodeByPodcastQuery {
  final String podcastSlug;

  String get payload => """
  query {
    podcast(slug: "$podcastSlug") {
      episodes {
        objects {
          title
          summary
          image
          link
          slug
          enclosure
          itunesDuration
        }
      }
    }
  }
  """;

  EpisodeByPodcastQuery({
    required this.podcastSlug,
  });
}
