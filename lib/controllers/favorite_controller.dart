import 'package:get/get.dart';

import '../models/show_model.dart';
import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _service;
  FavoriteController(this._service);

  final favorites = <ShowModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    favorites.assignAll(_service.getAll()); // load dari Hive
  }

  bool isFavorite(int id) => favorites.any((s) => s.id == id);

  /// Tambah jika belum favorit, hapus jika sudah.
  Future<void> toggle(ShowModel show) async {
    if (isFavorite(show.id)) {
      await remove(show.id);
    } else {
      await _service.add(show);
      favorites.add(show);
      _toast('Ditambahkan ke favorit');
    }
  }

  Future<void> remove(int id) async {
    await _service.remove(id);
    favorites.removeWhere((s) => s.id == id);
    _toast('Dihapus dari favorit');
  }

  void _toast(String msg) {
    Get.snackbar(
      'Favorit',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }
}
