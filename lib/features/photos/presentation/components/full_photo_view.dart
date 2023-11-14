import 'package:flutter/material.dart';
import 'package:moboom_app/core/presentation/components/cached_image_component.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/presentation/components/full_photo_title_component.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Full Photo'),
      ),
      body: ListView(
        children: [
          FullPhotoTitleComponent(title: photo.title),
          CachedImageComponent(imageUrl: photo.url),
        ],
      ),
    );
  }
}
