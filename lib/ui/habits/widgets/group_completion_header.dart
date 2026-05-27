import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class GroupCompletionHeader extends StatelessWidget {
  const GroupCompletionHeader({super.key, required this.percent, required this.streak});
  final int percent;
  final int streak;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(
      children: [
        Text(l.groupCompletion(percent), style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        Text('🔥 $streak'),
      ],
    );
  }
}
