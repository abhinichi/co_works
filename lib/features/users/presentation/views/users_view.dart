import 'package:co_works/core/error/failures.dart';
import 'package:co_works/core/theme/theme_controller.dart';
import 'package:co_works/core/utils/extensions/context_extensions.dart';
import 'package:co_works/core/utils/extensions/failure_extensions.dart';
import 'package:co_works/core/widgets/empty_view.dart';
import 'package:co_works/core/widgets/error_view.dart';
import 'package:co_works/core/widgets/loading_view.dart';
import 'package:co_works/features/auth/presentation/viewmodels/auth_controller.dart';
import 'package:co_works/features/users/domain/entities/app_user.dart';
import 'package:co_works/features/users/presentation/viewmodels/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// View for the users list. Renders the three states of the async ViewModel
/// (loading / data / error) and offers pull-to-refresh, a theme toggle and
/// logout.
class UsersView extends ConsumerWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersViewModelProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.usersTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.toggleThemeTooltip,
            icon: Icon(_iconForThemeMode(themeMode)),
            onPressed: () => ref.read(themeControllerProvider.notifier).cycle(),
          ),
          IconButton(
            tooltip: context.l10n.signOutTooltip,
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: usersAsync.when(
        loading: LoadingView.new,
        error: (error, _) => ErrorView(
          message: error is Failure
              ? error.localizedMessage(context.l10n)
              : error.toString(),
          onRetry: () => ref.read(usersViewModelProvider.notifier).refresh(),
        ),
        data: (users) => RefreshIndicator(
          onRefresh: () => ref.read(usersViewModelProvider.notifier).refresh(),
          child: users.isEmpty
              ? _EmptyUsers(message: context.l10n.usersEmpty)
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: users.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) =>
                      _UserTile(user: users[index]),
                ),
        ),
      ),
    );
  }

  IconData _iconForThemeMode(ThemeMode mode) => switch (mode) {
    ThemeMode.system => Icons.brightness_auto_outlined,
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
  };
}

/// Empty state kept scrollable so pull-to-refresh still works with no data.
class _EmptyUsers extends StatelessWidget {
  const _EmptyUsers({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: context.screenSize.height * 0.3),
        EmptyView(message: message),
      ],
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
      title: Text(user.fullName),
      subtitle: Text(user.email),
    );
  }
}
