

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String imageUrl;

  const PhotoViewPage(
      {super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PhotoView(
        imageProvider:NetworkImage(imageUrl),
        backgroundDecoration: BoxDecoration(color: Colors.green,),
        filterQuality: FilterQuality.high,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        enableRotation: true,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}