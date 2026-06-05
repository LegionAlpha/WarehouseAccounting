import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imagePath, this.iconSize = 32});

  final String? imagePath;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.inventory_2_outlined,
          color: scheme.onSurfaceVariant,
          size: iconSize,
        ),
      ),
    );

    final path = imagePath;
    if (path == null || path.isEmpty) return placeholder;

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}
