import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';

/// Login / logout + session di SharedPreferences.
class AuthController extends GetxController {
  final SharedPreferences _prefs;
  AuthController(this._prefs);

  final username = ''.obs;

  bool get isLoggedIn => _prefs.getBool(kPrefIsLoggedIn) ?? false;

  @override
  void onInit() {
    super.onInit();
    // Username dibaca dari SharedPreferences (dipakai di halaman Profil).
    username.value = _prefs.getString(kPrefUsername) ?? '';
  }

  Future<void> login(String user, String pass) async {
    final u = user.trim();

    if (u.isEmpty || pass.isEmpty) {
      _toast('Gagal', 'Username dan password wajib diisi');
      return;
    }

    if (u == kNim && pass == kPassword) {
      await _prefs.setBool(kPrefIsLoggedIn, true);
      await _prefs.setString(kPrefUsername, u);
      username.value = u;
      Get.offAll(() => MainPage()); // hapus halaman login dari stack
    } else {
      _toast('Login gagal', 'Username atau password salah');
    }
  }

  Future<void> logout() async {
    await _prefs.remove(kPrefIsLoggedIn);
    await _prefs.remove(kPrefUsername);
    username.value = '';
    Get.offAll(() => const LoginPage()); // kembali ke login, stack dibersihkan
  }

  void _toast(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }
}
