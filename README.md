# Flutter Base Project

A production-ready Flutter starter built on **MVVM + Clean Architecture**, with a
clear, feature-first folder structure and a modern, fully wired tech stack.

Clone it, rename it, delete the example features, and start shipping.

---

## Table of contents

1. [Tech stack](#tech-stack)
2. [Architecture at a glance](#architecture-at-a-glance)
3. [The three layers](#the-three-layers)
4. [Folder structure (what goes where)](#folder-structure-what-goes-where)
5. [Data flow: a request end-to-end](#data-flow-a-request-end-to-end)
6. [Code generation](#code-generation)
7. [Getting started](#getting-started)
8. [How to add a new feature](#how-to-add-a-new-feature)
9. [Conventions & guidelines](#conventions--guidelines)
10. [Testing](#testing)

---

## Tech stack

| Concern | Package | Why |
|---|---|---|
| State management / DI / ViewModels | **flutter_riverpod** + **riverpod_annotation/generator** | Compile-safe providers, no `BuildContext` needed, great testability. Riverpod doubles as the dependency-injection container. |
| Networking | **dio** + **retrofit** + **retrofit_generator** | Retrofit generates a type-safe API client from annotated interfaces; Dio handles interceptors, timeouts, etc. |
| Models / immutability | **freezed** + **json_serializable** | Generated immutable data classes with `copyWith`, `==`, and `to/fromJson`. |
| Routing | **go_router** | Declarative, URL-based routing with redirect guards. |
| Functional error handling | **dartz** (`Either`) | Repositories/use cases return `Either<Failure, T>` — errors are values, not surprises. |
| Secure storage | **flutter_secure_storage** | Encrypted storage for tokens. |
| Key-value storage | **shared_preferences** | Non-sensitive flags & settings. |
| Connectivity | **connectivity_plus** | Online/offline checks. |
| Logging | **logger** | Pretty, level-based logs (silenced in release). |

---

## Architecture at a glance

This project combines **Clean Architecture** (horizontal layers) with **MVVM**
(the pattern used inside the presentation layer) and a **feature-first**
organization (vertical slices).

```
                       ┌─────────────────────────────────────────┐
                       │              PRESENTATION                 │
   MVVM lives here →   │   View  ⇄  ViewModel (Riverpod Notifier)  │
                       └───────────────────┬───────────────────────┘
                                           │ calls use cases
                       ┌───────────────────▼───────────────────────┐
                       │                 DOMAIN                      │
                       │   Entities · Repository interfaces ·        │
                       │   Use cases   (pure Dart, no Flutter)       │
                       └───────────────────┬───────────────────────┘
                                           │ implemented by
                       ┌───────────────────▼───────────────────────┐
                       │                  DATA                       │
                       │   Models (DTOs) · Data sources ·            │
                       │   Repository implementations                │
                       └─────────────────────────────────────────────┘

Dependencies point INWARD only: Presentation → Domain ← Data.
The domain layer depends on nothing; the outer layers depend on it.
```

**The golden rule (Dependency Rule):** inner layers never import outer layers.
The domain doesn’t know Dio, Retrofit, Riverpod or Flutter even exist. This is
what makes the business logic portable and testable.

---

## The three layers

### 1. Domain — *what the app does*

Pure Dart. No Flutter, no JSON, no HTTP. It defines the business contracts.

- **Entities** (`domain/entities/`) — core business objects (e.g. `AuthToken`,
  `AppUser`). Plain classes, no serialization.
- **Repository interfaces** (`domain/repositories/`) — abstract contracts like
  `AuthRepository`. The domain says *what* it needs; the data layer decides *how*.
- **Use cases** (`domain/usecases/`) — one class per business action
  (`LoginUseCase`, `GetUsersUseCase`). Each implements
  `UseCase<ReturnType, Params>` and returns `Either<Failure, ReturnType>`.

### 2. Data — *how it’s done*

Implements the domain’s contracts and talks to the outside world.

- **Models / DTOs** (`data/models/`) — `freezed` + `json_serializable` classes
  that mirror the API JSON. Each exposes a `toEntity()` mapper.
- **Data sources** (`data/datasources/`):
  - *Remote* — a Retrofit `@RestApi()` interface (HTTP).
  - *Local* — wraps secure storage / preferences / a database.
- **Repository implementations** (`data/repositories/`) — orchestrate data
  sources, map DTOs → entities, and convert thrown exceptions into `Failure`s
  (via `guardApiCall`).

### 3. Presentation — *how it looks (MVVM)*

- **ViewModel** (`presentation/viewmodels/`) — a Riverpod `Notifier` /
  `AsyncNotifier`. Holds immutable UI **state**, exposes methods for user
  intent, and calls **use cases**. No `BuildContext`, no widgets, no Dio.
- **State** — for form-like screens, an immutable `freezed` class (e.g.
  `LoginState`). For load-and-display screens, an `AsyncValue<T>` produced by an
  `AsyncNotifier`.
- **View** (`presentation/views/`) — a thin widget that renders the state and
  forwards events to the ViewModel. Contains zero business logic.
- **Providers** (`presentation/providers/`) — the feature’s dependency-injection
  wiring (data source → repository → use case).

---

## Folder structure (what goes where)

```
lib/
├── main.dart                     # Default entry point → bootstrap(Flavor.dev)
├── bootstrap.dart                # Async startup: config, prefs, error handler, runApp(ProviderScope)
├── app.dart                      # Root MaterialApp.router widget (theme + router)
│
├── core/                         # Cross-cutting code shared by ALL features
│   ├── config/
│   │   └── app_config.dart       # Per-flavor runtime config (base URL, app name)
│   ├── constants/
│   │   ├── app_constants.dart    # Global constants (timeouts, page size, app name)
│   │   ├── api_endpoints.dart    # Relative REST paths, grouped by feature
│   │   └── storage_keys.dart     # Keys for secure storage & shared preferences
│   ├── error/
│   │   ├── exceptions.dart       # Data-layer exceptions (Server/Network/Cache…)
│   │   └── failures.dart         # Domain-layer failures (the Left of Either)
│   ├── network/
│   │   ├── dio_client.dart       # Builds the configured Dio instance
│   │   ├── api_error_mapper.dart # guardApiCall() + DioException → Failure mapping
│   │   ├── network_info.dart     # Connectivity abstraction
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart     # Adds bearer token; clears it on 401
│   │       └── logging_interceptor.dart  # Logs requests/responses (debug only)
│   ├── providers/
│   │   └── core_providers.dart   # DI for infra: Dio, storage, connectivity
│   ├── router/
│   │   ├── app_router.dart       # GoRouter + auth-aware redirect guard
│   │   ├── app_routes.dart       # Route path/name constants
│   │   └── splash_view.dart      # Shown while auth status is resolving
│   ├── storage/
│   │   ├── secure_storage_service.dart   # Tokens & secrets (encrypted)
│   │   └── preferences_service.dart      # Non-sensitive flags/settings
│   ├── theme/
│   │   ├── app_colors.dart       # Raw color palette
│   │   └── app_theme.dart        # Material 3 light/dark ThemeData
│   ├── usecase/
│   │   └── usecase.dart          # Base UseCase contract + NoParams
│   ├── utils/
│   │   ├── app_logger.dart       # Logging wrapper
│   │   ├── validators.dart       # Pure form validators
│   │   └── extensions/
│   │       └── context_extensions.dart   # BuildContext shortcuts
│   └── widgets/                  # Reusable widgets shared across features
│       ├── primary_button.dart
│       └── error_view.dart
│
└── features/                     # One folder per feature (vertical slice)
    ├── auth/                     # Example: login (POST + token persistence)
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   ├── auth_remote_data_source.dart   # Retrofit @RestApi
    │   │   │   └── auth_local_data_source.dart     # Token caching
    │   │   ├── models/
    │   │   │   ├── login_request_model.dart        # Request DTO
    │   │   │   └── auth_response_model.dart         # Response DTO + toEntity()
    │   │   └── repositories/
    │   │       └── auth_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── auth_token.dart
    │   │   ├── repositories/
    │   │   │   └── auth_repository.dart             # Interface
    │   │   └── usecases/
    │   │       ├── login_usecase.dart
    │   │       └── logout_usecase.dart
    │   └── presentation/
    │       ├── providers/
    │       │   └── auth_providers.dart              # Feature DI graph
    │       ├── viewmodels/
    │       │   ├── auth_controller.dart             # Global session status
    │       │   ├── login_state.dart                 # Immutable form state
    │       │   └── login_view_model.dart            # The ViewModel
    │       └── views/
    │           └── login_view.dart                  # The View
    │
    └── users/                    # Example: list (GET) using AsyncNotifier
        ├── data/
        │   ├── datasources/user_remote_data_source.dart
        │   ├── models/
        │   │   ├── user_model.dart
        │   │   └── user_list_response_model.dart    # Paginated envelope DTO
        │   └── repositories/user_repository_impl.dart
        ├── domain/
        │   ├── entities/app_user.dart
        │   ├── repositories/user_repository.dart
        │   └── usecases/get_users_usecase.dart
        └── presentation/
            ├── providers/user_providers.dart
            ├── viewmodels/users_view_model.dart     # AsyncNotifier
            └── views/users_view.dart

test/
├── core/validators_test.dart                # Pure unit test
├── features/auth/login_view_model_test.dart # ViewModel test (provider overrides)
└── widget_test.dart                         # View smoke test
```

> **`core/` vs `features/`** — if code is specific to one feature, it lives in
> that feature’s folder. If two or more features need it (or it’s pure
> infrastructure), it belongs in `core/`.

---

## Data flow: a request end-to-end

Tracing **“user taps Sign in”** through every layer:

1. **View** (`login_view.dart`) validates the form and calls
   `loginViewModelProvider.notifier.submit()`.
2. **ViewModel** (`login_view_model.dart`) sets `status = submitting`, then calls
   the **use case**: `ref.read(loginUseCaseProvider).call(LoginParams(...))`.
3. **Use case** (`login_usecase.dart`) forwards to the **repository interface**.
4. **Repository impl** (`auth_repository_impl.dart`) calls the **remote data
   source**, gets an `AuthResponseModel`, maps it to an `AuthToken` entity, and
   caches the token via the **local data source**. Any thrown error is converted
   to a `Failure` by `guardApiCall`.
5. **Remote data source** (Retrofit) performs the HTTP `POST` through **Dio**,
   whose **interceptors** attach the auth header and log the call.
6. The result bubbles back up as `Either<Failure, AuthToken>`. The ViewModel
   `fold`s it into a new `LoginState` (`success` or `failure`).
7. The **View** rebuilds from the new state; on success the
   `AuthController` flips to `authenticated` and **go_router** redirects to the
   users screen.

```
View → ViewModel → UseCase → Repository(interface)
                                   │
                              RepositoryImpl → RemoteDataSource(Retrofit) → Dio → API
                                   │                 LocalDataSource → SecureStorage
                                   ▼
                          Either<Failure, Entity>  ← (mapped back up)
```

---

## Code generation

This project uses generators for Riverpod, Retrofit, Freezed and JSON. Generated
files (`*.g.dart`, `*.freezed.dart`) sit next to their source via `part`
directives.

Run once:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch (regenerate on save) while developing:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

> Re-run the generator whenever you add/modify a `@riverpod`, `@RestApi`,
> `@freezed`, or `@JsonSerializable` declaration.

---

## Getting started

```bash
# 0. Rebrand the clone (package id + app name), then re-run pub get/fix
#    it triggers for you as part of the script
dart run tool/rename_project.dart --package-name=com.company.app --app-name="My App"

# 1. Install dependencies
flutter pub get

# 2. Generate code
dart run build_runner build --delete-conflicting-outputs

# 3. Run (uses the dev flavor by default)
flutter run

# 4. Analyze & test
flutter analyze
flutter test
```

**What `rename_project.dart` changes:**

| File(s) | What gets replaced |
|---|---|
| `pubspec.yaml` | `name:` (Dart package name, derived from `--app-name`) and `description:` |
| `lib/**/*.dart`, `test/**/*.dart` | Every `package:co_works/...` import; the `AppConstants.appName` string |
| `lib/l10n/app_en.arb` | The `appTitle` value |
| `android/app/build.gradle.kts` | `namespace` and `applicationId` |
| `android/.../AndroidManifest.xml` | `android:label` (points at `@string/app_name`, unchanged by the script) |
| `android/.../res/values/strings.xml` | The `app_name` string — the actual launcher label value |
| `android/.../MainActivity.kt` | `package` declaration, and the file is **moved** to match the new package path |
| `ios/Runner/Info.plist`, `ios/Runner.xcodeproj/project.pbxproj` | `CFBundleName`, `CFBundleDisplayName`, `PRODUCT_BUNDLE_IDENTIFIER` (incl. `.RunnerTests`) |

It then runs `flutter pub get` and `dart fix --apply` for you (a renamed Dart
package can re-sort relative to `package:flutter` imports, which `dart fix`
corrects), so `flutter analyze` is clean immediately after.

Only Android and iOS are supported — the macOS/Linux/Windows/web platform
folders were removed. If you need one of them back, run
`flutter create --platforms=<platform> .` from the repo root.

**Not touched** — do these by hand if needed: app icons/launch screens, CI
workflow file names, and anything outside the file list above. The launcher
label (`strings.xml`) is a native Android resource, not Flutter's ARB/l10n
system — the OS reads it before the Flutter engine starts, so `context.l10n`
strings can't reach it. To localize the label itself per device language, add
`values-<locale>/strings.xml` overrides (e.g. `values-fr/strings.xml`) with
the same `app_name` key.

The example talks to the public **reqres.in** sandbox API. The login screen is
pre-filled with its demo credentials (`eve.holt@reqres.in` / `cityslicka`) so the
flow works out of the box.

### Flavors

`AppConfig` already models `dev`, `staging`, and `prod`. To support real flavor
entry points, create `lib/main_dev.dart`, `lib/main_staging.dart`, and
`lib/main_prod.dart`, each calling `bootstrap(Flavor.x)`, and run with:

```bash
flutter run -t lib/main_dev.dart
```

---

## How to add a new feature

Say you’re adding a `products` feature. Create the slice and fill it top-down:

1. **Domain**
   - `features/products/domain/entities/product.dart`
   - `features/products/domain/repositories/product_repository.dart` (interface)
   - `features/products/domain/usecases/get_products_usecase.dart`
2. **Data**
   - `features/products/data/models/product_model.dart` (`freezed` + `toEntity()`)
   - `features/products/data/datasources/product_remote_data_source.dart`
     (Retrofit `@RestApi`)
   - `features/products/data/repositories/product_repository_impl.dart`
     (use `guardApiCall`)
3. **Presentation**
   - `features/products/presentation/providers/product_providers.dart`
     (wire data source → repository → use case)
   - `features/products/presentation/viewmodels/products_view_model.dart`
     (`AsyncNotifier` for lists, or `Notifier` + a `freezed` state for forms)
   - `features/products/presentation/views/products_view.dart`
4. Add an endpoint to `core/constants/api_endpoints.dart` and a route to
   `core/router/`.
5. Run the generator.

Copy the `users` feature as a template for read screens, or `auth` for forms.

---

## Conventions & guidelines

- **Dependency Rule first.** Never import `data/` or Flutter from `domain/`.
- **Views are dumb.** No `if`-business-logic, no network calls, no error mapping
  in widgets — push it into the ViewModel/use case.
- **Errors are values.** Cross layer boundaries with `Either<Failure, T>`, not
  thrown exceptions. Exceptions stay inside the data layer.
- **One use case = one action.** Keep them small and named after the action.
- **DTOs ≠ entities.** Models live in `data/` and own JSON; entities live in
  `domain/` and are framework-free. Convert with `toEntity()`.
- **Riverpod is the DI container.** Construct dependencies in `*_providers.dart`,
  not inside widgets or ViewModels.
- **Constants, not magic strings.** Routes, endpoints, and storage keys all have
  a single home in `core/`.

---

## Testing

```bash
flutter test
```

The included tests show the three most common patterns:

- **`test/core/validators_test.dart`** — pure functions, no setup.
- **`test/features/auth/login_view_model_test.dart`** — a ViewModel tested with a
  `ProviderContainer` and a single provider override
  (`authRepositoryProvider.overrideWithValue(FakeAuthRepository())`). Because the
  whole data layer hides behind one provider, swapping in a fake is trivial and
  no network/storage is touched.
- **`test/widget_test.dart`** — a View pumped in isolation inside a
  `ProviderScope`.

This is the payoff of the architecture: each layer can be verified on its own.
