import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';

class RootShell extends StatelessWidget {
  const RootShell({super.key, required this.child, required this.location});
  final Widget child;
  final String location;

  static const _tabs = <String>['/', '/stats', '/friends', '/profile'];

  int get _currentIndex {
    final idx = _tabs.indexWhere(
      (p) => location == p || location.startsWith('$p/'),
    );
    return idx == -1 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final items = <_NavItem>[
      _NavItem(Icons.home_outlined, Icons.home_rounded, l.navHome),
      _NavItem(Icons.bar_chart_outlined, Icons.bar_chart_rounded, l.navStats),
      _NavItem(Icons.group_outlined, Icons.group_rounded, l.navFriends),
      _NavItem(Icons.person_outline, Icons.person_rounded, l.navProfile),
    ];
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: cs.surfaceContainerHighest, width: 1),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: List.generate(items.length, (i) {
                final selected = _currentIndex == i;
                final item = items[i];
                return Expanded(
                  child: InkWell(
                    onTap: () => context.go(_tabs[i]),
                    splashColor: cs.primary.withValues(alpha: 0.08),
                    highlightColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selected ? item.activeIcon : item.icon,
                          size: 26,
                          color: selected
                              ? cs.primary
                              : cs.onSurface.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: selected
                                ? cs.primary
                                : cs.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.activeIcon, this.label);
  final IconData icon;
  final IconData activeIcon;
  final String label;
}
