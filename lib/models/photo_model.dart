class Photo {
  final int id;
  final String photographer;
  final String photographerUrl;
  final String url;
  final String imageUrl;

  Photo({
    required this.id,
    required this.photographer,
    required this.photographerUrl,
    required this.url,
    required this.imageUrl,
  });
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      photographer: json['photographer'] as String,
      photographerUrl: json['photographer_url'] as String,
      url: json['url'] as String,
      imageUrl: json['src']['original'] as String,
    );
  }
}
