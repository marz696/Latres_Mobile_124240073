import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/rating_text.dart';
import '../widgets/show_image.dart';

class DetailPage extends StatelessWidget {
  final int showId;

  const DetailPage({super.key, required this.showId});

  @override
  Widget build(BuildContext context) {
    // tag = id, supaya tiap show punya controller sendiri
    final c = Get.put(DetailController(showId), tag: '$showId');
    final fav = Get.find<FavoriteController>();

    return Scaffold(
      // AppBar otomatis punya tombol back -> bisa kembali ke page sebelumnya
      appBar: AppBar(title: const Text('Detail')),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final s = c.show.value;
        if (s == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.error.value, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: c.fetchDetail,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowImage(url: s.imageOriginal ?? s.imageMedium, height: 420),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RatingText(rating: s.rating, size: 15),
                    const SizedBox(height: 12),

                    // Genre
                    if (s.genres.isEmpty)
                      const Text('Genre: -', style: TextStyle(color: Colors.white70))
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: s.genres
                            .map((g) => Chip(
                                  label: Text(g),
                                  backgroundColor: kCard,
                                  side: BorderSide.none,
                                ))
                            .toList(),
                      ),
                    const SizedBox(height: 12),

                    // Tombol favorit (tambah / hapus)
                    Obx(() {
                      final isFav = fav.isFavorite(s.id);
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => fav.toggle(s),
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                          ),
                          label: Text(
                            isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),

                    // Summary / Overview
                    const Text(
                      'Overview',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s.summary.isEmpty ? 'Tidak ada ringkasan.' : s.summary,
                      style: const TextStyle(color: Colors.white70, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
