/// Model sederhana untuk satu TV show.
/// Dipakai untuk list (home), detail, dan penyimpanan favorit (Hive).
class ShowModel {
  final int id;
  final String name;
  final String? imageMedium;
  final String? imageOriginal;
  final double? rating;
  final List<String> genres;
  final String summary;

  const ShowModel({
    required this.id,
    required this.name,
    this.imageMedium,
    this.imageOriginal,
    this.rating,
    this.genres = const [],
    this.summary = '',
  });

  /// Parse dari JSON TVMaze.
  /// Perhatikan: image, rating.average, dan summary bisa bernilai null!
  factory ShowModel.fromJson(Map<String, dynamic> json) {
    final image = json['image'] as Map<String, dynamic>?;
    final ratingMap = json['rating'] as Map<String, dynamic>?;

    return ShowModel(
      id: json['id'] as int,
      name: (json['name'] ?? '-') as String,
      imageMedium: _secure(image?['medium'] as String?),
      imageOriginal: _secure(image?['original'] as String?),
      rating: (ratingMap?['average'] as num?)?.toDouble(),
      genres: List<String>.from(json['genres'] ?? const []),
      summary: _stripHtml(json['summary'] as String?),
    );
  }

  /// Dipakai saat menyimpan ke Hive (Map biasa, tanpa TypeAdapter).
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'imageMedium': imageMedium,
        'imageOriginal': imageOriginal,
        'rating': rating,
        'genres': genres,
        'summary': summary,
      };

  /// Dipakai saat membaca dari Hive.
  factory ShowModel.fromMap(Map<String, dynamic> map) {
    return ShowModel(
      id: map['id'] as int,
      name: (map['name'] ?? '-') as String,
      imageMedium: map['imageMedium'] as String?,
      imageOriginal: map['imageOriginal'] as String?,
      rating: (map['rating'] as num?)?.toDouble(),
      genres: List<String>.from(map['genres'] ?? const []),
      summary: (map['summary'] ?? '') as String,
    );
  }

  // Summary dari TVMaze berupa HTML (<p>, <b>, ...) -> bersihkan tag-nya.
  static String _stripHtml(String? html) {
    if (html == null) return '';
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  // Pastikan URL gambar memakai https (Android memblokir http biasa).
  static String? _secure(String? url) => url?.replaceFirst('http://', 'https://');
}
