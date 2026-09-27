import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';

void main() {
  testWidgets('VUNO home presents its primary discovery content', (
    tester,
  ) async {
    await tester.pumpWidget(const VunoApp());
    expect(find.text('VUNO'), findsOneWidget);
    expect(find.text('Everything you need, wherever you go.'), findsOneWidget);
    expect(find.text('Ask VUNO anything...'), findsOneWidget);
    expect(find.text('Trending near you'), findsOneWidget);
    expect(find.text('Eat'), findsOneWidget);
    expect(find.text('Events'), findsOneWidget);

    await tester.tap(find.text('Eat'));
    await tester.pumpAndSettle();
    expect(find.text('Eat nearby'), findsOneWidget);
  });
}
