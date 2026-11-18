import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/rating_text.dart';
import '../widgets/show_image.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoriteController c = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Favorit')),
      body: Obx(() {
        if (c.favorites.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada favorit.\nTambahkan dari halaman detail.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: c.favorites.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final s = c.favorites[i];
            return Material(
              color: kCard,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                // Klik -> ke detail page
                onTap: () => Get.to(() => DetailPage(showId: s.id)),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 48,
                    height: 64,
                    child: ShowImage(url: s.imageMedium),
                  ),
                ),
                title: Text(
                  s.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Align(
                  alignment: Alignment.centerLeft,
                  child: RatingText(rating: s.rating),
                ),
                // Hapus dari favorit
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: kAccent),
                  onPressed: () => c.remove(s.id),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
