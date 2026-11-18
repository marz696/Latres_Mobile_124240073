import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/show_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skuy Nonton!')),
      body: Obx(() {
        // 1) loading indicator
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2) error + tombol coba lagi
        if (c.error.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.error.value, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: c.fetchShows,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        // 3) grid data (+ tarik ke bawah untuk refresh)
        return RefreshIndicator(
          onRefresh: () => c.fetchShows(silent: true),
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemCount: c.shows.length,
            itemBuilder: (context, i) => ShowCard(show: c.shows[i]),
          ),
        );
      }),
    );
  }
}
