import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

void main() {
  group('Form Button Test', () {
    testWidgets('Enable State', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: ThemeData(
            primaryColor: Colors.red,
          ),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(
              text: 'Next',
              disabled: false,
            ),
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
      expect(
        (tester
                .firstWidget<AnimatedContainer>(
                  find.byType(AnimatedContainer),
                )
                .decoration! as BoxDecoration)
            .color,
        Colors.red,
      );
    });

    testWidgets('Disabled State', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(
              text: 'Next',
              disabled: true,
            ),
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
        Colors.grey.shade400,
      );
    });

    testWidgets('Disabled State DarkMode', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(
            platformBrightness: Brightness.dark,
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(
              text: 'Next',
              disabled: true,
            ),
          ),
        ),
      );
      expect(
        (tester
                .firstWidget<AnimatedContainer>(
                  find.byType(AnimatedContainer),
                )
                .decoration! as BoxDecoration)
            .color,
        Colors.grey.shade800,
      );
    });

    testWidgets('Disabled State LightMode', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(
            platformBrightness: Brightness.light,
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(
              text: 'Next',
              disabled: true,
            ),
          ),
        ),
      );
      expect(
        (tester
                .firstWidget<AnimatedContainer>(
                  find.byType(AnimatedContainer),
                )
                .decoration! as BoxDecoration)
            .color,
        Colors.grey.shade300,
      );
    });
  });
}
