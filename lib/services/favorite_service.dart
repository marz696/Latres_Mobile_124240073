import 'package:hive_flutter/hive_flutter.dart';

import '../config/constants.dart';
import '../models/show_model.dart';

/// Akses penyimpanan favorit memakai Hive.
/// Box dibuka sekali di main(), lalu dipakai di sini.
/// Key = id show, value = Map hasil ShowModel.toMap().
class FavoriteService {
  Box get _box => Hive.box(kFavoriteBox);

  List<ShowModel> getAll() {
    return _box.values
        .map((e) => ShowModel.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  bool contains(int id) => _box.containsKey(id);

  Future<void> add(ShowModel show) => _box.put(show.id, show.toMap());

  Future<void> remove(int id) => _box.delete(id);
}
