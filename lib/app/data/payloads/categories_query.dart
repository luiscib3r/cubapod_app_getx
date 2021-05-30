class CategoriesQuery {
  String get payload => """
          query {
            categories {
              name
              slug
              description
              img
              podcastsCount
            }
          }
        """;
}
