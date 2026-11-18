import 'package:get/get.dart';

/// Menyimpan index tab BottomNavigationBar.
class MainController extends GetxController {
  final index = 0.obs;

  void changeTab(int i) => index.value = i;
}
