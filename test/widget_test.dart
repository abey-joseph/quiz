import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/main.dart';

void main() {
  testWidgets('Quiz starts with first question', (WidgetTester tester) async {
    await tester.pumpWidget(const QuizApp());
    expect(find.text('What is the capital of France?'), findsOneWidget);
  });
}
