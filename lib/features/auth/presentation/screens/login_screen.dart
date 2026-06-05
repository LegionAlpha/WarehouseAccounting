import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:warehouse_accounting/core/constants/demo_admin.dart';
import 'package:warehouse_accounting/core/router/app_routes.dart';
import 'package:warehouse_accounting/core/theme/app_colors.dart';
import 'package:warehouse_accounting/core/theme/app_dimens.dart';
import 'package:warehouse_accounting/core/utils/localization_extensions.dart';
import 'package:warehouse_accounting/core/utils/snackbar_extension.dart';
import 'package:warehouse_accounting/core/utils/validators.dart';
import 'package:warehouse_accounting/core/widgets/language_menu_button.dart';
import 'package:warehouse_accounting/domain/failures/app_exceptions.dart';
import 'package:warehouse_accounting/features/auth/presentation/providers/auth_controller.dart';
import 'package:warehouse_accounting/features/auth/presentation/widgets/auth_header.dart';
import 'package:warehouse_accounting/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .login(
            email: _emailController.text,
            password: _passwordController.text,
          );
    } on AppException catch (error) {
      if (mounted) context.showErrorSnackBar(error.localizedMessage(l10n));
    } catch (_) {
      if (mounted) context.showErrorSnackBar(l10n.errorGeneric);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _fillDemoAdmin() {
    _emailController.text = DemoAdmin.email;
    _passwordController.text = DemoAdmin.password;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        actions: const [
          LanguageMenuButton(),
          SizedBox(width: AppSpacing.sm),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(
                      title: l10n.loginTitle,
                      subtitle: l10n.loginSubtitle,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      enabled: !_isSubmitting,
                      decoration: InputDecoration(
                        labelText: l10n.fieldEmail,
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                      ),
                      validator: (value) => Validators.email(value, l10n),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      enabled: !_isSubmitting,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: l10n.fieldPassword,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      validator: (value) => Validators.password(value, l10n),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const _ButtonSpinner()
                          : Text(l10n.buttonSignIn),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => context.go(AppRoutes.register),
                      child: Text(l10n.linkNoAccount),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _DemoAdminHint(
                      onTap: _isSubmitting ? null : _fillDemoAdmin,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(strokeWidth: 2.4),
    );
  }
}

class _DemoAdminHint extends StatelessWidget {
  const _DemoAdminHint({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.demoAdminHint(DemoAdmin.email, DemoAdmin.password),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (onTap != null)
                Icon(Icons.touch_app_outlined, size: 18, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
