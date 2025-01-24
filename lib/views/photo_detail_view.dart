import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../models/photo_model.dart';

class PhotoDetailView extends StatelessWidget {
  final Photo photo;

  const PhotoDetailView({Key? key, required this.photo}) : super(key: key);

  // Request permission and download image
  Future<void> downloadImage(BuildContext context) async {
    // Check and request storage permission
    final status = await Permission.storage.request();

    // Check the permission status
    if (status.isGranted) {
      try {
        // Get the directory where the image will be saved
        final tempDir = await getTemporaryDirectory();
        final savePath = '${tempDir.path}/${photo.id}.jpg';

        // Download the image and save it to the path
        await Dio().download(photo.imageUrl, savePath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloaded to $savePath')),
        );
      } catch (e) {
        // If download fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    } else if (status.isDenied) {
      // Permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Storage permission denied. Please grant permission to download images.')),
      );
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, guide the user to settings
      openAppSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Storage permission permanently denied. Please enable it in app settings.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo Details')),
      body: Column(
        children: [
          Expanded(
            child: Image.network(photo.imageUrl),
          ),
          ElevatedButton(
            onPressed: () => downloadImage(context),
            child: Text('Download'),
          ),
        ],
      ),
    );
  }
}
