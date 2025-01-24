import 'package:dio/dio.dart';
import '../models/photo_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.pexels.com/v1/';
  final String _apiKey =
      'xr3IU46h0siFcfT9fQsY3BscynxQP1J51KbRlmxOd7UnDtVxAlUej57w';

  Future<List<Photo>> fetchPhotos(int page) async {
    try {
      print('Fetching photos from API, page: $page');
      final response = await _dio.get(
        '${_baseUrl}curated',
        queryParameters: {'page': page, 'per_page': 20},
        options: Options(headers: {'Authorization': _apiKey}),
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      if (response.statusCode == 200) {
        final List photos = response.data['photos'];
        return photos.map((photo) => Photo.fromJson(photo)).toList();
      } else {
        throw Exception('Failed to fetch photos: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching photos: $e');
      throw Exception('Failed to fetch photos');
    }
  }
}
