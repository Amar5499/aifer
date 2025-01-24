import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../views/photo_detail_view.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;

  const PhotoGridItem({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PhotoDetailView(photo: photo)),
      ),
      child: Card(
        child: Image.network(
          photo.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
