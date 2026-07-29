import 'package:co_works/core/error/failures.dart';
import 'package:co_works/features/auth/domain/entities/auth_token.dart';
import 'package:co_works/features/auth/domain/repositories/auth_repository.dart';
import 'package:co_works/features/auth/presentation/providers/auth_providers.dart';
import 'package:co_works/features/auth/presentation/viewmodels/auth_controller.dart';
import 'package:co_works/features/auth/presentation/viewmodels/login_state.dart';
import 'package:co_works/features/auth/presentation/viewmodels/login_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake repository: overriding a single provider swaps the whole data layer for
/// a deterministic test double — no Dio, no network, no storage.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({required this.loginResult, this.loggedIn = false});

  final Either<Failure, AuthToken> loginResult;
  bool loggedIn;

  @override
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
  }) async => loginResult;

  @override
  Future<Either<Failure, Unit>> logout() async {
    loggedIn = false;
    return const Right(unit);
  }

  @override
  Future<bool> isLoggedIn() async => loggedIn;

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) async {
    return const Right(unit);
  }
}

ProviderContainer _containerWith(AuthRepository repo) {
  final container = ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('LoginViewModel.submit', () {
    test('sets status to success and marks session authenticated', () async {
      final container = _containerWith(
        FakeAuthRepository(
          loginResult: const Right(AuthToken(accessToken: 'token')),
        ),
      );
      final viewModel = container.read(loginViewModelProvider.notifier);

      viewModel.emailChanged('eve.holt@reqres.in');
      viewModel.passwordChanged('cityslicka');
      await viewModel.submit();

      expect(
        container.read(loginViewModelProvider).status,
        LoginStatus.success,
      );
      expect(container.read(authControllerProvider), AuthStatus.authenticated);
    });

    test('sets status to failure and exposes the message', () async {
      final container = _containerWith(
        FakeAuthRepository(
          loginResult: const Left(UnauthorizedFailure('Bad credentials')),
        ),
      );
      final viewModel = container.read(loginViewModelProvider.notifier);

      viewModel.emailChanged('eve.holt@reqres.in');
      viewModel.passwordChanged('wrong');
      await viewModel.submit();

      final state = container.read(loginViewModelProvider);
      expect(state.status, LoginStatus.failure);
      expect(state.failure, isA<UnauthorizedFailure>());
    });
  });
}
