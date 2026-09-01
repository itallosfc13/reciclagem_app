import 'package:flutter_test/flutter_test.dart';

import 'package:reciclagem_app/main.dart';

void main() {
  testWidgets('Aplicativo inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const ReciclaApp());

    expect(find.text('Olá! ♻️'), findsOneWidget);
    expect(find.text('ReciclaApp'), findsOneWidget);
  });
}