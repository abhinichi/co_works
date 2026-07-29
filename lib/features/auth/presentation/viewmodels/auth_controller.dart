import 'package:co_works/core/usecase/usecase.dart';
import 'package:co_works/features/auth/presentation/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// High-level authentication status that drives app navigation/routing.
enum AuthStatus { unknown, authenticated, unauthenticated }

/// Session-wide auth state.
///
/// This is a `keepAlive` ViewModel that holds the *global* auth status. The
/// router (`app_router.dart`) listens to it to redirect between the login flow
/// and the authenticated area. Screen-specific logic (the login form) lives in
/// [LoginViewModel] instead — this controller only tracks "are we signed in".
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthStatus build() {
    // Kick off an async check; until it resolves the status is `unknown`,
    // which keeps the user on the splash screen.
    _resolveInitialStatus();
    return AuthStatus.unknown;
  }

  Future<void> _resolveInitialStatus() async {
    final isLoggedIn = await ref.read(authRepositoryProvider).isLoggedIn();
    state = isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  /// Called by [LoginViewModel] after a successful login.
  void markAuthenticated() => state = AuthStatus.authenticated;

  Future<void> logout() async {
    await ref.read(logoutUseCaseProvider).call(const NoParams());
    state = AuthStatus.unauthenticated;
  }
}
