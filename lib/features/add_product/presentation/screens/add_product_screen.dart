import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warehouse_accounting/core/providers/app_providers.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/services/image_storage_service.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/snackbar_extension.dart';
import 'package:warehouse_accounting/core/utils/validators.dart';
import 'package:warehouse_accounting/core/widgets/product_image.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imagePath;
  bool _isSubmitting = false;
  bool _isPickingImage = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourceSheet() async {
    final l10n = AppLocalizations.of(context);
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.addProductPickCamera),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.addProductPickGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source != null) await _pickImage(source);
  }

  Future<void> _pickImage(ImageSource source) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isPickingImage = true);
    try {
      final path = await ref
          .read(imageStorageServiceProvider)
          .pickAndStore(source);
      if (path != null && mounted) setState(() => _imagePath = path);
    } catch (_) {
      if (mounted) context.showErrorSnackBar(l10n.errorGeneric);
    } finally {
      if (mounted) setState(() => _isPickingImage = false);
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isSubmitting = true);
    try {
      final product = await ref
          .read(productRepositoryProvider)
          .createProduct(
            name: _nameController.text,
            description: _descriptionController.text,
            createdBy: user.id,
            imagePath: _imagePath,
          );
      if (mounted) {
        context.showSuccessSnackBar(l10n.productCreated);
        context.pushReplacement(AppRoutes.productQr(product.id));
      }
    } catch (_) {
      if (mounted) context.showErrorSnackBar(l10n.errorGeneric);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addProductTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _ImagePickerField(
                imagePath: _imagePath,
                isBusy: _isPickingImage,
                hint: l10n.addProductImageHint,
                onTap: _isSubmitting ? null : _showImageSourceSheet,
                onRemove: _isSubmitting
                    ? null
                    : () => setState(() => _imagePath = null),
              ),
              const SizedBox(height: AppSpacing.xl),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                enabled: !_isSubmitting,
                decoration: InputDecoration(
                  labelText: l10n.addProductName,
                  prefixIcon: const Icon(Icons.label_outline_rounded),
                ),
                validator: (value) => Validators.productName(value, l10n),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _descriptionController,
                enabled: !_isSubmitting,
                minLines: 3,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l10n.addProductDescription,
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 64),
                    child: Icon(Icons.notes_rounded),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              FilledButton.icon(
                onPressed: _isSubmitting ? null : _submit,
                icon: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.2),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(l10n.buttonCreateProduct),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePickerField extends StatelessWidget {
  const _ImagePickerField({
    required this.imagePath,
    required this.isBusy,
    required this.hint,
    required this.onTap,
    required this.onRemove,
  });

  final String? imagePath;
  final bool isBusy;
  final String hint;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasImage = imagePath != null;

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Material(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadii.lg),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : hasImage
                  ? ProductImage(imagePath: imagePath)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: 40,
                          color: scheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          l10n.addProductImage,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                          ),
                          child: Text(
                            hint,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          if (hasImage && !isBusy)
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Material(
                color: scheme.surface.withValues(alpha: 0.9),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: l10n.addProductRemoveImage,
                  icon: const Icon(Icons.close_rounded),
                  onPressed: onRemove,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
