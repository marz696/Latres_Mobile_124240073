import 'package:get/get.dart';

import '../models/show_model.dart';
import '../services/tvmaze_service.dart';

class DetailController extends GetxController {
  final int showId;
  DetailController(this.showId);

  final TvMazeService _service = TvMazeService();

  final show = Rxn<ShowModel>(); // nullable observable
  final isLoading = true.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true;
    error.value = '';
    try {
      show.value = await _service.fetchShowDetail(showId);
    } catch (e) {
      error.value = 'Gagal memuat detail.\n\n$e';
    } finally {
      isLoading.value = false;
    }
  }
}
