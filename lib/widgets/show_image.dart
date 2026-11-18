import 'package:flutter/material.dart';

/// Gambar jaringan dengan loading indicator & placeholder jika gagal / null.
class ShowImage extends StatelessWidget {
  final String? url;
  final double? height;

  const ShowImage({super.key, required this.url, this.height});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: double.infinity,
      height: height,
      color: Colors.grey.shade900,
      child: const Icon(Icons.movie_outlined, color: Colors.white38, size: 40),
    );

    if (url == null) return placeholder;

    return Image.network(
      url!,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: double.infinity,
          height: height,
          color: Colors.grey.shade900,
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}
