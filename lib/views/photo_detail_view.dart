import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../models/photo_model.dart';

class PhotoDetailView extends StatelessWidget {
  final Photo photo;

  const PhotoDetailView({super.key, required this.photo});

  Future<void> downloadImage(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final tempDir = await getTemporaryDirectory();
        final savePath = '${tempDir.path}/${photo.id}.jpg';
        await Dio().download(photo.imageUrl, savePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloaded to $savePath')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Storage permission denied. Please grant permission to download images.')),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Storage permission permanently denied. Please enable it in app settings.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Details')),
      body: Column(
        children: [
          Expanded(
            child: Image.network(photo.imageUrl),
          ),
          ElevatedButton(
            onPressed: () => downloadImage(context),
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }
}
