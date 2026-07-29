import 'package:co_works/core/router/app_routes.dart';
import 'package:co_works/core/router/splash_view.dart';
import 'package:co_works/features/auth/presentation/viewmodels/auth_controller.dart';
import 'package:co_works/features/auth/presentation/views/forgot_password_view.dart';
import 'package:co_works/features/auth/presentation/views/login_view.dart';
import 'package:co_works/features/users/presentation/views/users_view.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// The app's [GoRouter], exposed as a Riverpod provider so it can react to
/// global auth state.
///
/// `redirect` is the single source of truth for navigation guards:
///  * while auth status is `unknown` → stay on the splash screen;
///  * unauthenticated → forced to `/login` or `/forgot-password`;
///  * authenticated → kept out of auth screens.
///
/// A [ValueNotifier] bridges the Riverpod [AuthController] to go_router's
/// `refreshListenable`, so the router re-evaluates `redirect` on every auth
/// change.
@riverpod
GoRouter goRouter(Ref ref) {
  final refresh = ValueNotifier<AuthStatus>(ref.read(authControllerProvider));
  ref.listen<AuthStatus>(
    authControllerProvider,
    (_, next) => refresh.value = next,
  );
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    redirect: (context, state) {
      final status = ref.read(authControllerProvider);
      final location = state.matchedLocation;

      if (status == AuthStatus.unknown) {
        return location == AppRoutes.splash ? AppRoutes.login : AppRoutes.splash;
      }

      final isLoggedIn = status == AuthStatus.authenticated;
      final isOnAuthFlow =
          location == AppRoutes.login ||
          location == AppRoutes.forgotPassword ||
          location == AppRoutes.splash;

      if (!isLoggedIn) {
        return isOnAuthFlow ? null : AppRoutes.login;
      }
      if (isOnAuthFlow) return AppRoutes.users;
      return AppRoutes.login;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: AppRoutes.forgotPasswordName,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: AppRoutes.users,
        name: AppRoutes.usersName,
        builder: (context, state) => const UsersView(),
      ),
    ],
  );
}
