class CategoryModel {
  final String name;
  final String slug;
  final String description;
  final String img;
  final int poctastsCount;

  CategoryModel({
    required this.name,
    required this.slug,
    required this.description,
    required this.img,
    required this.poctastsCount,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        slug = json['slug'],
        description = json['description'],
        img = json['img'],
        poctastsCount = json['podcastsCount'];
}
