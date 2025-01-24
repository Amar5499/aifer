import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/photo_provider.dart';
import '../widgets/photo_grid_item.dart';

class HomeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aifer Wallpaper App'),
        centerTitle: true,
      ),
      body: photosAsync.when(
        data: (photos) => NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              ref.read(photoProvider.notifier).fetchPhotos();
            }
            return false;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: photos.length,
            itemBuilder: (_, index) => PhotoGridItem(photo: photos[index]),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
