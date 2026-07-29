# CLAUDE.md

Guidance for Claude (and any engineer) working in this repository. Read this
**before** writing code. The goal is to keep the codebase maintainable,
scalable, readable, and consistent with the architecture already in place.

---

## 1. Project overview

A production-ready Flutter **base/template** project demonstrating a clean,
layered architecture that new features can be built on by copying the existing
pattern.

**Stack**

| Concern            | Choice                                        |
| ------------------ | --------------------------------------------- |
| Architecture       | MVVM + Clean Architecture (feature-first)     |
| State management    | Riverpod (code-generated, `@riverpod`)        |
| Navigation         | `go_router` (auth-aware redirects)            |
| Networking         | `dio` + `retrofit`                            |
| Models / DTOs      | `freezed` + `json_serializable`               |
| Functional errors  | `dartz` (`Either<Failure, T>`)                |
| Storage            | `shared_preferences` + `flutter_secure_storage` |
| Localization       | `flutter_localizations` + `gen-l10n` (ARB)    |
| Logging            | `logger` (wrapped by `AppLogger`)             |

---

## 2. First rule — understand before you change

Never immediately start writing code. First:

1. Analyze the repository and the layer you are about to touch.
2. Follow the existing architecture, folder structure, naming, and conventions.
3. Identify reusable widgets/utilities/enums/constants before adding new ones.
4. Do not introduce a new architecture, state-management library, or package
   without a clear, stated justification.

Leave every file in a better state than you found it.

---

## 3. Architecture

Three layers per feature, plus a shared `core`. Dependencies point **inward**
(presentation → domain ← data); the domain layer knows nothing about Flutter,
Dio, or storage.

```
Presentation (View → ViewModel)      ← Flutter, Riverpod
        │  calls
        ▼
Domain (UseCase → Repository iface)   ← pure Dart, no Flutter
        ▲  implemented by
        │
Data (RepositoryImpl → DataSource → Model/DTO)  ← Dio, Retrofit, storage
```

**Data flow (read):** View watches ViewModel → ViewModel calls UseCase →
UseCase calls Repository interface → RepositoryImpl calls DataSource → DTO is
mapped to a domain Entity → returned as `Either<Failure, Entity>` → ViewModel
folds it into UI state → View renders.

**Rules**

- Business logic never lives in widgets, screens, or `build` methods.
- Never call a DataSource, Dio, or storage directly from the UI.
- DTOs/`freezed` models stay in the data layer; entities are what domain and
  presentation use. Map DTO → entity with `toEntity()` in the data layer.
- Repositories return `Either<Failure, T>`; they translate exceptions into
  `Failure`s (via `guardApiCall`) so higher layers never see raw exceptions.

---

## 4. Folder structure

```
lib/
  main.dart / main_dev.dart / main_staging.dart / main_prod.dart  # flavor entries
  bootstrap.dart          # shared async startup + global error handlers
  app.dart                # root MaterialApp.router (theme + l10n + routing)
  l10n/                   # app_en.arb (+ generated/ AppLocalizations)
  core/
    config/     AppConfig (per-flavor runtime config)
    constants/  AppConstants, ApiEndpoints, StorageKeys
    error/      exceptions (data) + failures (domain, sealed)
    network/    DioClient, api_error_mapper (guardApiCall), NetworkInfo, interceptors/
    providers/  core_providers (network + storage DI graph)
    router/     app_router, app_routes, splash_view
    storage/    PreferencesService, SecureStorageService
    theme/      AppTheme, AppColors, ThemeController
    usecase/    UseCase base contract
    utils/      Validators, AppLogger, extensions/
    widgets/    shared widgets (PrimaryButton, AppTextField, LoadingView, EmptyView, ErrorView)
  features/<feature>/
    data/         datasources/  models/  repositories/
    domain/       entities/     repositories/  usecases/
    presentation/ providers/    viewmodels/    views/
```

When adding a feature, mirror `features/auth` or `features/users` exactly.

---

## 5. Getting started / common commands

```bash
flutter pub get                      # install deps (also runs gen-l10n)
flutter gen-l10n                     # regenerate AppLocalizations from ARB
dart run build_runner build          # regenerate *.g.dart / *.freezed.dart
dart run build_runner watch          # ...continuously while developing
flutter analyze                      # static analysis (must be clean)
flutter test                         # run all tests
dart format .                        # format
flutter run -t lib/main_dev.dart     # run a flavor (dev/staging/prod)
```

> Generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/generated/`) are
> committed. Regenerate and commit them whenever you change an annotated class
> or an ARB file.

---

## 6. Conventions by concern

- **State management** — Riverpod with codegen. Screen logic lives in a
  `Notifier`/`AsyncNotifier` ViewModel; global/session state (e.g. auth) in a
  `keepAlive` controller. Keep state immutable (`freezed`), minimize rebuilds,
  dispose resources. DI is done via providers — one `*_providers.dart` per
  feature is the only place concrete implementations are wired.
- **Views** — thin `Consumer(Stateful)Widget`s. Read state to render, forward
  intent to the ViewModel, handle side-effects with `ref.listen`. No business
  logic. `const` constructors wherever possible.
- **Error handling** — data sources throw `AppException`; repositories wrap
  calls in `guardApiCall` → `Either<Failure, T>`; the presentation layer maps a
  `Failure` to a localized string via `FailureLocalizer`. Never swallow errors;
  log the unexpected through `AppLogger`.
- **Networking** — endpoints in `ApiEndpoints`; base URL per flavor in
  `AppConfig`; auth + logging via interceptors.
- **Routing** — `go_router` provider reacting to `AuthController`; reference
  paths/names through `AppRoutes`, never raw strings.
- **Theming** — Material 3 from `AppTheme`; read colors/text via
  `context.colors` / `context.textTheme`; never hardcode colors. `ThemeController`
  persists the user's `ThemeMode`.
- **Localization** — no user-facing hardcoded strings. Add a key to
  `lib/l10n/app_en.arb`, run `flutter gen-l10n`, use `context.l10n.<key>`.
- **Enums over magic values** — statuses, routes, roles, etc. are enums.
- **Constants** — no hardcoded strings/numbers/durations/paddings; centralize in
  `constants/` or the theme.
- **Extensions** — repeated helper logic becomes an extension (see
  `context_extensions`, `failure_extensions`).
- **Naming** — descriptive, no abbreviations. Classes name responsibilities,
  methods name actions.

---

## 7. Documentation & comments standard

**Whenever a change is made, update the documentation and comments to match.**
Stale docs are worse than none.

- Every public **type** (class, mixin, enum, extension, top-level function) has a
  `///` dartdoc explaining its responsibility and, where relevant, *why* it
  exists and how it fits the architecture.
- Document **non-obvious** members: methods with side-effects, ordering
  requirements, nullability meaning, or subtle behavior. Reference other symbols
  with `[BracketLinks]`.
- Comments explain **why**, not **what**. Do not restate the code. Prefer
  self-explanatory names over a comment.
- Do **not** add trivial per-field comments to obvious value objects (e.g.
  `AppUser.email`) — that is noise and fights readability (KISS).
- Keep public API docs, `README.md`, and this file in sync with behavior
  changes. If you change a flow, update the dartdoc that describes it.
- Remove temporary/debug comments and logs before finishing.
- Never document (or log) secrets: passwords, tokens, API keys, PII.

---

## 8. Adding a new feature (step-by-step)

1. `features/<name>/domain` — define the `Entity`, the `Repository` interface,
   and `UseCase`(s) returning `Either<Failure, T>`.
2. `features/<name>/data` — define `freezed` DTO(s) with `toEntity()`, the
   Retrofit/remote (and any local) `DataSource`, and the `RepositoryImpl`
   (wrap calls in `guardApiCall`, pass `NetworkInfo`).
3. `features/<name>/presentation/providers` — wire DataSource → Repository →
   UseCase as `@riverpod` providers.
4. `features/<name>/presentation/viewmodels` — a `Notifier`/`AsyncNotifier`
   ViewModel with immutable state.
5. `features/<name>/presentation/views` — a thin View rendering the state.
6. Register the route in `AppRoutes` + `app_router.dart`.
7. Add localized strings to the ARB; run `gen-l10n` and `build_runner`.
8. Add/adjust tests. Run `flutter analyze` and `flutter test`.

---

## 9. Testing

- Keep business logic independent of Flutter so it is unit-testable.
- Prefer overriding a single provider with a fake to swap a whole layer (see
  `test/features/auth/login_view_model_test.dart`).
- Add or update tests when changing behavior; call out important edge cases.
- Widget tests that render a View must supply
  `AppLocalizations.localizationsDelegates`.

---

## 10. Engineering principles

Follow **SOLID, Clean Code, DRY, KISS, YAGNI**. Prefer composition over
inheritance. Functions do one thing and stay small. Reduce duplication —
extract reusable widgets/extensions/constants. Consider performance (avoid
unnecessary rebuilds/allocations, prefer `const`, lazy loading, pagination).
Support accessibility and dynamic text scaling where practical. Challenge poor
design decisions respectfully and explain trade-offs.

Before finishing any task, self-review for: duplication, unnecessary
complexity, architecture violations, inconsistent naming, missing null-safety,
edge cases, performance issues, memory leaks, and — per §7 — documentation that
has drifted from the code.

---

## 11. Git

Use **Conventional Commits**: `feat:`, `fix:`, `refactor:`, `perf:`, `docs:`,
`test:`, `build:`, `ci:`, `chore:`. Keep the subject imperative and concise; use
the body to explain *why*. Commit generated code alongside the source that
produced it.

**No AI/assistant attribution — anywhere.** Commits are authored solely by the
human developer. Do not add `Co-Authored-By` assistant trailers, "generated by"
notes, or any tool/assistant reference in commit messages, pull request titles
or descriptions, code comments, or documentation. This applies to every commit
and PR without needing to be restated.

---

## 12. Lint & formatting

Static analysis is configured in `analysis_options.yaml` (extends
`flutter_lints` with a stricter curated rule set). Generated files are excluded.
`flutter analyze` **must be clean** and code **must be formatted**
(`dart format .`) before a change is considered done. These same checks run in
CI (see §13), so an unformatted or failing change cannot be merged clean.

---

## 13. Continuous integration

`.github/workflows/ci.yml` runs on every push to `main` / `riverpod` /
`riverpod-ai` and on every pull request. It is the automatic gatekeeper that
turns the standards above from "should" into "must":

1. Sets up the pinned Flutter version and installs dependencies.
2. `dart format --output=none --set-exit-if-changed .` — fails on unformatted code.
3. `flutter analyze` — fails on any analysis/lint issue.
4. `flutter test` — fails if any test breaks.

A green check means the change is safe to merge; a red X shows exactly which
step failed. Committed generated code (`*.g.dart`, `*.freezed.dart`,
`lib/l10n/generated/`) means CI does not need to run `build_runner`; regenerate
and commit those locally whenever you change an annotated class or an ARB file.
