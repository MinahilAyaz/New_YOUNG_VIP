import 'package:flutter_test/flutter_test.dart';
import 'package:young_vip/main.dart';
import 'package:young_vip/views/homepage_view.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the HomepageView is present on initial launch.
    expect(find.byType(HomepageView), findsOneWidget);
    expect(find.text('Start Free'), findsOneWidget);
  });
}
