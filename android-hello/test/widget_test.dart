import 'package:flutter_test/flutter_test.dart';
import 'package:hello_app/main.dart';

void main() {
  testWidgets('shows the Share Daily brand on the opening screen', (
    tester,
  ) async {
    await tester.pumpWidget(const ShareDailyApp());

    expect(find.text('餘數日常'), findsOneWidget);
    expect(find.text('SHARE DAILY'), findsOneWidget);
    expect(find.text('讓一點餘裕，沿著信任抵達日常。'), findsOneWidget);
  });
}
