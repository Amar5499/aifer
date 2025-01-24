import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/photo_model.dart';
import '../services/api_service.dart';

final photoProvider =
    StateNotifierProvider<PhotoNotifier, AsyncValue<List<Photo>>>((ref) {
  return PhotoNotifier(ApiService());
});

class PhotoNotifier extends StateNotifier<AsyncValue<List<Photo>>> {
  final ApiService apiService;
  int _currentPage = 1;
  bool _hasMore = true;

  PhotoNotifier(this.apiService) : super(const AsyncValue.loading()) {
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    if (!_hasMore) return;
    try {
      final photos = await apiService.fetchPhotos(_currentPage);
      if (photos.isEmpty) {
        _hasMore = false;
      }
      state = AsyncValue.data([
        ...state.asData?.value ?? [],
        ...photos,
      ]);
      _currentPage++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
