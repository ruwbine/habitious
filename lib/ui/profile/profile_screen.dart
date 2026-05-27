import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_preferences.dart';
import '../../data/models/friend.dart';
import '../../data/models/friend_request.dart';
import '../../data/models/theme_preference.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/social_repository.dart';
import '../../l10n/app_localizations.dart';
import 'view_models/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProfileViewModel(ctx.read<ProfileRepository>())..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final TextEditingController _searchController = TextEditingController();
  List<Friend> _searchResults = const [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final vm = context.watch<ProfileViewModel>();
    final p = vm.profile;
    if (p == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(l.profileTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettings(context, vm),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          _ProfileHeaderCard(profile: p),
          const SizedBox(height: 22),
          _SectionTitle(l.addFriends),
          const SizedBox(height: 10),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, size: 20),
              hintText: l.searchByUsername,
            ),
            onChanged: (q) async {
              final results = await context
                  .read<SocialRepository>()
                  .searchByUsername(q);
              if (mounted) setState(() => _searchResults = results);
            },
          ),
          if (_searchResults.isNotEmpty) ...[
            const SizedBox(height: 8),
            ..._searchResults.map(
              (f) => _RowTile(
                leadingIcon: Icons.person_outline,
                title: f.displayName,
              ),
            ),
          ],
          const SizedBox(height: 12),
          _RowTile(
            leadingIcon: Icons.qr_code,
            title: l.myQrCode,
            onTap: () => showDialog<void>(
              context: context,
              builder: (_) => AlertDialog(
                content: SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Icon(
                      Icons.qr_code_2,
                      size: 160,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _RowTile(
            leadingIcon: Icons.qr_code_scanner,
            title: l.scanQr,
            onTap: () => showDialog<void>(
              context: context,
              builder: (_) => AlertDialog(content: Text(l.scanQr)),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder<List<FriendRequest>>(
            stream: context.read<SocialRepository>().watchIncomingRequests(),
            builder: (_, snapshot) {
              final reqs = snapshot.data ?? const [];
              if (reqs.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(l.friendRequests(reqs.length)),
                  const SizedBox(height: 10),
                  ...reqs.map(
                    (r) => _FriendRequestRow(request: r),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
          StreamBuilder<List<Friend>>(
            stream: context.read<SocialRepository>().watchFriends(),
            builder: (_, snapshot) {
              final friends = snapshot.data ?? const [];
              if (friends.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(l.myFriends),
                  const SizedBox(height: 10),
                  ...friends.take(3).map(
                        (f) => _FriendRow(friend: f),
                      ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context, ProfileViewModel vm) {
    final l = AppLocalizations.of(context);
    final p = vm.profile!;
    final prefs = context.read<AppPreferences>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.hardcoreMode),
                value: p.hardcoreMode,
                onChanged: (v) => vm.toggleHardcoreModeCommand.run(v),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('${l.themeSystem} / ${l.themeLight} / ${l.themeDark}'),
                trailing: DropdownButton<ThemePreference>(
                  value: p.themePreference,
                  underline: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                      value: ThemePreference.system,
                      child: Text(l.themeSystem),
                    ),
                    DropdownMenuItem(
                      value: ThemePreference.light,
                      child: Text(l.themeLight),
                    ),
                    DropdownMenuItem(
                      value: ThemePreference.dark,
                      child: Text(l.themeDark),
                    ),
                  ],
                  onChanged: (v) async {
                    if (v == null) return;
                    await vm.setThemePreferenceCommand.run(v);
                    prefs.setTheme(v.mode);
                  },
                ),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('${l.languageRu} / ${l.languageEn}'),
                trailing: DropdownButton<Locale>(
                  value: p.locale,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(value: Locale('ru'), child: Text('RU')),
                    DropdownMenuItem(value: Locale('en'), child: Text('EN')),
                  ],
                  onChanged: (v) async {
                    if (v == null) return;
                    await vm.setLocaleCommand.run(v);
                    prefs.setLocale(v);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({required this.profile});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final xpInLevel = profile.xp % 1000;
    final xpProgress = (xpInLevel / 1000).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: cs.surfaceContainerHighest,
            child: Text(
              profile.displayName.isNotEmpty
                  ? profile.displayName.characters.first
                  : '?',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      l.level(profile.level),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: xpProgress,
                          backgroundColor: cs.surfaceContainerHighest,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(cs.primary),
                        ),
                      ),
                    ),
                  ],
                ),
                if (profile.hardcoreMode) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.flash_on, size: 14, color: cs.primary),
                      const SizedBox(width: 4),
                      Text(
                        l.hardcoreMode,
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: cs.onSurface.withValues(alpha: 0.7),
      ),
    );
  }
}

class _RowTile extends StatelessWidget {
  const _RowTile({
    required this.leadingIcon,
    required this.title,
    this.onTap,
  });
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(leadingIcon, size: 20, color: cs.onSurface),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: cs.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendRequestRow extends StatelessWidget {
  const _FriendRequestRow({required this.request});
  final FriendRequest request;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: cs.surfaceContainerHighest,
            child: Text(request.friend.displayName.characters.first),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              request.friend.displayName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          _ActionCircle(
            icon: Icons.check,
            color: cs.primary,
            onTap: () => context
                .read<SocialRepository>()
                .acceptFriendRequest(request.friend.id),
          ),
          const SizedBox(width: 8),
          _ActionCircle(
            icon: Icons.close,
            color: cs.onSurface.withValues(alpha: 0.4),
            onTap: () => context
                .read<SocialRepository>()
                .declineFriendRequest(request.friend.id),
          ),
        ],
      ),
    );
  }
}

class _ActionCircle extends StatelessWidget {
  const _ActionCircle({
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 22,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

class _FriendRow extends StatelessWidget {
  const _FriendRow({required this.friend});
  final Friend friend;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: cs.surfaceContainerHighest,
            child: Text(
              friend.displayName.isNotEmpty
                  ? friend.displayName.characters.first
                  : '?',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.displayName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  l.sharedHabitsCount(friend.sharedHabitsCount),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_horiz,
            color: cs.onSurface.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
