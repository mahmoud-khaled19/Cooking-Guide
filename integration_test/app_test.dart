import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/view/main_screens/layout_screen.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import 'package:food_app/widgets/text_form_field_widget.dart';
import 'package:integration_test/integration_test.dart';
import 'package:food_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('description', () {
    testWidgets('verify login screen with correct email and password',
        (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byType(DefaultTextFormField).at(0), 'koota1@gmail.com');
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.enterText(
          find.byType(DefaultTextFormField).at(1), '123456@Mk');
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.tap(find.byType(DefaultButton));
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      expect(find.byType(LayoutScreen), findsOneWidget);
    });
  });
}
