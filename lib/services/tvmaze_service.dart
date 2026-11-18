import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../models/show_model.dart';

/// Semua urusan fetch & parse API ada di sini, TERPISAH dari UI.
class TvMazeService {
  static const _timeout = Duration(seconds: 20);

  /// GET https://api.tvmaze.com/shows
  Future<List<ShowModel>> fetchShows() async {
    final response =
        await http.get(Uri.parse('$kApiBase/shows')).timeout(_timeout);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => ShowModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Gagal memuat daftar show (kode ${response.statusCode})');
  }

  /// GET https://api.tvmaze.com/shows/{id}
  Future<ShowModel> fetchShowDetail(int id) async {
    final response =
        await http.get(Uri.parse('$kApiBase/shows/$id')).timeout(_timeout);

    if (response.statusCode == 200) {
      return ShowModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Gagal memuat detail show (kode ${response.statusCode})');
  }
}
