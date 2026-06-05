import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';

class ImageStorageService {
  ImageStorageService({required ImagePicker picker, required Uuid uuid})
    : _picker = picker,
      _uuid = uuid;

  final ImagePicker _picker;
  final Uuid _uuid;

  static const String _folder = 'product_images';

  Future<String?> pickAndStore(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
    if (picked == null) return null;

    final documents = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(documents.path, _folder));
    if (!imagesDir.existsSync()) {
      await imagesDir.create(recursive: true);
    }

    final extension = p.extension(picked.path).isNotEmpty
        ? p.extension(picked.path)
        : '.jpg';
    final destination = p.join(imagesDir.path, '${_uuid.v4()}$extension');
    await picked.saveTo(destination);
    return destination;
  }
}

final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

final imageStorageServiceProvider = Provider<ImageStorageService>(
  (ref) => ImageStorageService(
    picker: ref.watch(imagePickerProvider),
    uuid: ref.watch(uuidProvider),
  ),
);
