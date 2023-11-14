import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageComponent extends StatelessWidget {
  const CachedImageComponent({
    super.key,
    required this.imageUrl,
    this.progressIndicatorColor = Colors.deepPurpleAccent,
  });

  final String imageUrl;
  final Color progressIndicatorColor;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (_, __) => CircularProgressIndicator(color: progressIndicatorColor),
      errorWidget: (_, __, ___) => Icon(Icons.error),
    );
  }
}
