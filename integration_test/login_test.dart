import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:valbury_test/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'empty email and password, tap on the login button, verify error message',
      (tester) async {
        // Load app widget.
        await tester.pumpWidget(const MyApp(), );

        // Verify the login button is existing.
        final buttonLogin = find.byKey(const ValueKey('button_login'));

        // Emulate a tap on the login button.
        await tester.tap(buttonLogin);

        // Trigger a frame.
        await tester.pumpAndSettle();

        // Verify the counter increments by 1.
        expect(find.text('Credential anda tidak sesuai, mohon coba kembali!'), findsOneWidget);
      },
    );
  });
}
