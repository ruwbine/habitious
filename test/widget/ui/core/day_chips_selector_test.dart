import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/l10n/app_localizations.dart';
import 'package:habitious/ui/core/widgets/day_chips_selector.dart';

Widget _wrap(Widget w) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: w),
    );

void main() {
  testWidgets('tapping a chip toggles its selection', (tester) async {
    var selected = <int>{0, 1, 2, 3, 4}; // Mon-Fri
    await tester.pumpWidget(_wrap(StatefulBuilder(builder: (context, setState) {
      return DayChipsSelector(
        selectedDays: selected,
        onChanged: (next) => setState(() => selected = next),
      );
    })));
    await tester.pumpAndSettle();

    expect(find.text('Sat'), findsOneWidget);
    await tester.tap(find.text('Sat'));
    await tester.pump();
    expect(selected.contains(5), isTrue);
  });
}
