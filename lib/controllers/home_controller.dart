import 'package:get/get.dart';

import '../models/show_model.dart';
import '../services/tvmaze_service.dart';

class HomeController extends GetxController {
  final TvMazeService _service = TvMazeService();

  final shows = <ShowModel>[].obs;
  final isLoading = true.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  /// [silent] = true dipakai saat pull-to-refresh (tanpa spinner layar penuh).
  Future<void> fetchShows({bool silent = false}) async {
    if (!silent) isLoading.value = true;
    error.value = '';
    try {
      final result = await _service.fetchShows();
      shows.assignAll(result);
    } catch (e) {
      if (shows.isEmpty) {
        error.value = 'Gagal memuat data.\nPeriksa koneksi internet kamu.\n\n$e';
      } else {
        Get.snackbar('Gagal memuat ulang', '$e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
