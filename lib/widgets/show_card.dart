import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../models/show_model.dart';
import '../pages/detail_page.dart';
import 'rating_text.dart';
import 'show_image.dart';

/// Kartu show untuk grid di Home: gambar, judul, rating.
class ShowCard extends StatelessWidget {
  final ShowModel show;

  const ShowCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCard,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // Navigasi ke detail page saat diklik
        onTap: () => Get.to(() => DetailPage(showId: show.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: ShowImage(url: show.imageMedium)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    show.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingText(rating: show.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
