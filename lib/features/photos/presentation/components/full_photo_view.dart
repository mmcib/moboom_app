import 'package:flutter/material.dart';
import 'package:moboom_app/core/presentation/components/cached_image_component.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';

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
      body: Column(
        children: [
          CachedImageComponent(imageUrl: photo.url),
          Align(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      photo.title,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
