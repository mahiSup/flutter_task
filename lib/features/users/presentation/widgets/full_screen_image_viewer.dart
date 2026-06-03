import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String username;

  const FullScreenImagePage({
    super.key,
    required this.imageUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          username,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Hero(
        tag: imageUrl,
        child: PhotoView(
          imageProvider:
          CachedNetworkImageProvider(
            imageUrl,
          ),
          backgroundDecoration:
          const BoxDecoration(
            color: Colors.black,
          ),
          minScale:
          PhotoViewComputedScale.contained,
          maxScale:
          PhotoViewComputedScale.covered *
              3,
          loadingBuilder:
              (context, event) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}