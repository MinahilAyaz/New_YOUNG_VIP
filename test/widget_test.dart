import 'package:flutter_test/flutter_test.dart';
import 'package:young_vip/main.dart';
import 'package:young_vip/widgets/custom_bottom_nav_bar.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the bottom navigation bar is present on home screen.
    expect(find.byType(CustomBottomNavBar), findsOneWidget);
  });
}
