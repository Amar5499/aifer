// models/photo.dart

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

  // Add this updated fromJson method
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int, // Ensure this is an int (it should be)
      photographer: json['photographer'] as String, // This should be a String
      photographerUrl:
          json['photographer_url'] as String, // This should be a String
      url: json['url'] as String, // This should be a String
      imageUrl: json['src']['original'] as String, // This should be a String
    );
  }
}
