import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

void main() {
  group('Form Button Test', () {
    testWidgets('Enable State', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FormButton(
            text: 'Next',
            disabled: false,
          ),
        ),
      );
      expect(find.text('Next'), findsOneWidget);
      expect(
        tester
            .firstWidget<AnimatedDefaultTextStyle>(
              find.byType(AnimatedDefaultTextStyle),
            )
            .style
            .color,
        Colors.white,
      );
    });
  });
}
