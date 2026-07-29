import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/utils/extensions/context_extensions.dart';
import 'package:flutter_base_project/core/utils/extensions/failure_extensions.dart';
import 'package:flutter_base_project/core/utils/validators.dart';
import 'package:flutter_base_project/core/widgets/app_text_field.dart';
import 'package:flutter_base_project/core/widgets/primary_button.dart';
import 'package:flutter_base_project/features/auth/presentation/viewmodels/login_state.dart';
import 'package:flutter_base_project/features/auth/presentation/viewmodels/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The View in MVVM: a thin, declarative widget.
///
/// It (1) reads [LoginState] from [LoginViewModel] to render, (2) forwards user
/// intent back to the ViewModel, and (3) reacts to side-effects (errors) via
/// `ref.listen`. It holds no business logic. Navigation on success is handled
/// by the router reacting to `AuthController`.
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();

  // Demo credentials accepted by the reqres.in sandbox API.
  final _emailController = TextEditingController(text: 'eve.holt@reqres.in');
  final _passwordController = TextEditingController(text: 'cityslicka');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ref.read(loginViewModelProvider.notifier).submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);

    // Surface failures as a snackbar without rebuilding the whole tree for it.
    ref.listen(loginViewModelProvider, (previous, next) {
      final failure = next.failure;
      if (next.status == LoginStatus.failure && failure != null) {
        context.showSnackBar(failure.localizedMessage(context.l10n));
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.signInAppBarTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: context.colors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  context.l10n.loginWelcome,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _emailController,
                  label: context.l10n.emailLabel,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.email,
                  onChanged: viewModel.emailChanged,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  label: context.l10n.passwordLabel,
                  obscureText: state.obscurePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: viewModel.toggleObscurePassword,
                  ),
                  validator: Validators.password,
                  onChanged: viewModel.passwordChanged,
                  onFieldSubmitted: (_) => _onSubmit(),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: context.l10n.signInButton,
                  isLoading: state.isSubmitting,
                  onPressed: _onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
