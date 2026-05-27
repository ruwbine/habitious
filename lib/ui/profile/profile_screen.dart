import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_preferences.dart';
import '../../data/models/theme_preference.dart';
import '../../data/repositories/profile_repository.dart';
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

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final vm = context.watch<ProfileViewModel>();
    final prefs = context.read<AppPreferences>();
    final p = vm.profile;
    if (p == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(l.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            CircleAvatar(
              radius: 32,
              child: Text(
                p.displayName.isNotEmpty ? p.displayName[0] : '?',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.displayName, style: Theme.of(context).textTheme.titleMedium),
                Text(l.level(p.level)),
              ],
            ),
          ]),
          const Divider(height: 32),
          SwitchListTile(
            title: Text(l.hardcoreMode),
            value: p.hardcoreMode,
            onChanged: (v) => vm.toggleHardcoreModeCommand.run(v),
          ),
          ListTile(
            title: Text('${l.themeSystem} / ${l.themeLight} / ${l.themeDark}'),
            trailing: DropdownButton<ThemePreference>(
              value: p.themePreference,
              items: [
                DropdownMenuItem(value: ThemePreference.system, child: Text(l.themeSystem)),
                DropdownMenuItem(value: ThemePreference.light, child: Text(l.themeLight)),
                DropdownMenuItem(value: ThemePreference.dark, child: Text(l.themeDark)),
              ],
              onChanged: (v) async {
                if (v == null) return;
                await vm.setThemePreferenceCommand.run(v);
                prefs.setTheme(v.mode);
              },
            ),
          ),
          ListTile(
            title: Text('${l.languageRu} / ${l.languageEn}'),
            trailing: DropdownButton<Locale>(
              value: p.locale,
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
    );
  }
}
