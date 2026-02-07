import 'package:flutter_test/flutter_test.dart';
import 'package:apex/app.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.text('Post a Job'), findsOneWidget);
  });
}
