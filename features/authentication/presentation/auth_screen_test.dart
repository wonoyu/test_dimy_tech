import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_dimy_tech/src/app.dart';

import '../../../mocks.dart';

void main() {
  group("AuthScreen", () {
    late MockFakeAuthRepository mockFakeAuthRepository;

    setUp(() {
      mockFakeAuthRepository = MockFakeAuthRepository();
    });

    testWidgets("login with PIN and logout", (tester) async {
      await tester
          .pumpWidget(const ProviderScope(overrides: [], child: MyApp()));
      await tester.pumpAndSettle();
      final inputPIN = find.byKey(const Key("PIN"));
      final button = find.byKey(const Key("buttonLogin"));
      expect(inputPIN, findsOneWidget);
      await tester.enterText(inputPIN, "2022");
      await tester.pumpAndSettle();
      await tester.tap(button);
      await tester.pump();
      final circularIndicator = find.byType(CircularProgressIndicator);
      expect(circularIndicator, findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      expect(circularIndicator, findsNothing);
      final buttonLogout = find.byKey(const Key("buttonLogout"));
      expect(buttonLogout, findsOneWidget);
      await tester.tap(buttonLogout);
      await tester.pump();
      expect(button, findsOneWidget);
    });
  });
}
