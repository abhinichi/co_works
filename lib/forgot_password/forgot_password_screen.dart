import 'package:co_works/common_widget/building_painter.dart';
import 'package:co_works/main.dart';
import 'package:co_works/theme/app_theme.dart';
import 'package:co_works/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isHoveringSend = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendResetLink() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.resetLinkSent(_emailController.text),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Language Selector
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: Localizations.localeOf(context).languageCode,
                            icon: const Icon(Icons.language, size: 16, color: Color(0xFF64748B)),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                appLocaleNotifier.value = Locale(newValue);
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'ja',
                                child: Text('日本語'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // CoWork Logo Icon
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomPaint(
                          painter: BuildingPainter(
                            windowColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // CoWork Brand Name
                    Text(
                      AppLocalizations.of(context)!.appName,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // MEMBER LOGIN Subtitle
                    Text(
                      AppLocalizations.of(context)!.memberLogin,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E9AA8),
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Forgot Password Title
                    Text(
                      AppLocalizations.of(context)!.forgotPasswordTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Instructions
                    Text(
                      AppLocalizations.of(context)!.forgotPasswordInstruction,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),

                    // Email or User ID Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.emailOrUserIdLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1E293B),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.mail_outline,
                          color: Color(0xFF64748B),
                          size: 22,
                        ),
                        hintText: AppLocalizations.of(context)!.emailOrUserIdPlaceholder,
                        hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.5,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!.userIdRequired;
                        }
                        // Accept either basic email or simple user ID
                        if (value.contains('@')) {
                          final emailRegExp = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegExp.hasMatch(value.trim())) {
                            return AppLocalizations.of(context)!.userIdInvalid;
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    // Send Reset Link Button
                    MouseRegion(
                      onEnter: (_) => setState(() => _isHoveringSend = true),
                      onExit: (_) => setState(() => _isHoveringSend = false),
                      child: GestureDetector(
                        onTap: _handleSendResetLink,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            color: _isHoveringSend
                                ? AppColors.primaryDark
                                : Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.sendResetLinkLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Back to Login
                    GestureDetector(
                      onTap: () {
                        context.go('/');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.backToLogin,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Divider Line
                    const Divider(color: Color(0xFFE2E8F0), thickness: 1.0),
                    const SizedBox(height: 24),

                    // Footer Links (Help Center / Privacy Policy / Terms of Use)
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)!.helpCenter,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)!.privacyPolicy,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)!.termsOfUse,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Copyright text
                    Text(
                      AppLocalizations.of(context)!.copyrightText,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      textAlign: TextAlign.center,
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
