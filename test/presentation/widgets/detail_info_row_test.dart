import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/presentation/widgets/detail_widgets.dart';
import 'package:rim_elementary/themes/app_theme.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: lightTheme(fontFamily: kFontFamilyNunito),
      home: Scaffold(body: child),
    );
  }

  testWidgets('DetailInfoRow shows label and value', (tester) async {
    await tester.pumpWidget(
      wrap(
        const DetailInfoRow(label: 'Gender', value: 'Male'),
      ),
    );

    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets('DetailInfoRow shows leading icon when provided', (tester) async {
    await tester.pumpWidget(
      wrap(
        const DetailInfoRow(
          label: 'Gender',
          value: 'Male',
          leading: Icon(Icons.male, size: 18),
        ),
      ),
    );

    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.byIcon(Icons.male), findsOneWidget);
  });

  testWidgets('DetailInfoRow shows em dash for empty value', (tester) async {
    await tester.pumpWidget(
      wrap(
        const DetailInfoRow(label: 'Type', value: ''),
      ),
    );

    expect(find.text('—'), findsOneWidget);
  });
}
