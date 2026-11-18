import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

/// Kerangka utama: BottomNavigationBar (Home, Favorit, Profil).
class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // IndexedStack: state tiap tab terjaga (Home tidak fetch ulang)
        body: IndexedStack(
          index: c.index.value,
          children: [
            HomePage(),
            FavoritePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: c.index.value,
          onTap: c.changeTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
