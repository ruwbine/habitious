import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/friend.dart';
import '../../data/repositories/social_repository.dart';
import '../../l10n/app_localizations.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final repo = context.read<SocialRepository>();
    return Scaffold(
      appBar: AppBar(title: Text(l.navFriends)),
      body: StreamBuilder<List<Friend>>(
        stream: repo.watchFriends(),
        builder: (_, snapshot) {
          final list = snapshot.data ?? const [];
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (_, i) => ListTile(
              leading: CircleAvatar(child: Text(list[i].displayName.characters.first)),
              title: Text(list[i].displayName),
              subtitle: Text(l.sharedHabitsCount(list[i].sharedHabitsCount)),
            ),
          );
        },
      ),
    );
  }
}
