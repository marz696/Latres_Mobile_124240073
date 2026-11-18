import 'package:flutter/material.dart';

/// Ikon bintang + angka rating (atau "-" kalau null).
class RatingText extends StatelessWidget {
  final double? rating;
  final double size;

  const RatingText({super.key, required this.rating, this.size = 13});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.amber, size: size + 3),
        const SizedBox(width: 4),
        Text(
          rating?.toStringAsFixed(1) ?? '-',
          style: TextStyle(fontSize: size, color: Colors.white70),
        ),
      ],
    );
  }
}
