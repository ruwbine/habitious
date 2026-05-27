import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habitious/app.dart';

void main() {
  testWidgets('app builds without throwing', (tester) async {
    await tester.pumpWidget(HabitiousApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
  });
}
