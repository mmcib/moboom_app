import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';

// TODO: Update the UI
// TODO: Add responsiveness
// TODO: Add i10n
class FullPhotoView extends StatelessWidget {
  const FullPhotoView({
    super.key,
    required this.photo,
  });

  final PhotoModel photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Full Photo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('title: ${photo.title}'),
            const SizedBox(height: 12),
            CachedNetworkImage(
              imageUrl: photo.url,
              placeholder: (_, __) => CircularProgressIndicator(color: Colors.deepPurpleAccent),
              errorWidget: (_, __, ___) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
