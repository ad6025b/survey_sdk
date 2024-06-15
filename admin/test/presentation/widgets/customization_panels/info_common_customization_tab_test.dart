import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_admin/presentation/widgets/customization_items/color_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_items/radius_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/info/info_common_customization_tab.dart';

import '../app_tester.dart';

void main() {
  group(
    'Info common customization panel',
    () {
      const redColorCode = 'FFF44336';
      const textSizeString = '20';
      const textSize = 20;
      const textSizeStringWithLetters = '1LLL';
      const textSizeWithLetters = 1;
      const textSizeStringMoreThan2 = '233';
      const redColor = Color(0xfff44336);

      final data =
          ValueNotifier<InfoQuestionData>(const InfoQuestionData.common());
      final infoCommonCustomPanel = AppTester(
        child: ValueListenableBuilder<InfoQuestionData>(
          valueListenable: data,
          builder: (_, value, child) => InfoCommonCustomizationTab(
            title: 'title',
            onChange: (QuestionData<dynamic> newData) {
              data.value = newData as InfoQuestionData;
            },
            editable: value,
          ),
        ),
      );

      testWidgets(
        'load widget',
        (tester) async {
          await tester.pumpWidget(infoCommonCustomPanel);
          expect(find.byType(ColorCustomizationItem), findsNWidgets(5));
          expect(find.byType(RadiusCustomizationItem), findsNWidgets(1));
        },
      );
      testWidgets(
        'pick colors test',
        (tester) async {
          await tester.pumpWidget(infoCommonCustomPanel);
          await tester.pumpAndSettle();
          final colorTextFields = find.byType(ColorCustomizationItem);
          for (var i = 0; i < colorTextFields.evaluate().length; i++) {
            await tester.enterText(
              colorTextFields.at(i),
              redColorCode,
            );
            await tester.testTextInput.receiveAction(TextInputAction.done);
          }
          await tester.pump();
          expect(find.text(redColorCode), findsNWidgets(5));
          expect(data.value.theme?.fill, redColor);
          expect(data.value.theme?.titleColor, redColor);
          expect(data.value.theme?.subtitleColor, redColor);
          expect(data.value.theme?.primaryButtonFill, redColor);
          expect(data.value.theme?.primaryButtonTextColor, redColor);
        },
      );
      testWidgets(
        'pick text width and radius test',
        (tester) async {
          await tester.pumpWidget(infoCommonCustomPanel);

          await tester.enterText(
            find.byType(CustomizationTextField).at(2),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.titleSize, textSize);

          await tester.enterText(
            find.byType(CustomizationTextField).at(4),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.subtitleSize, textSize);

          await tester.enterText(
            find.byType(CustomizationTextField).at(7),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.primaryButtonTextSize, textSize);

          await tester.enterText(
            find.byType(CustomizationTextField).at(8),
            textSizeString,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.primaryButtonRadius, textSize);

          expect(find.text(textSizeString), findsNWidgets(4));
        },
      );
      testWidgets(
        'pick text width and radius with letters',
        (tester) async {
          await tester.pumpWidget(infoCommonCustomPanel);

          await tester.enterText(
            find.byType(CustomizationTextField).at(2),
            '',
          );
          for (var i = 0; i < textSizeStringWithLetters.length; i++) {
            tester.testTextInput.updateEditingValue(
              TextEditingValue(text: textSizeStringWithLetters[i]),
            );
          }
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.titleSize, textSizeWithLetters);

          await tester.enterText(
            find.byType(CustomizationTextField).at(4),
            '',
          );
          for (var i = 0; i < textSizeStringWithLetters.length; i++) {
            tester.testTextInput.updateEditingValue(
              TextEditingValue(text: textSizeStringWithLetters[i]),
            );
          }
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.subtitleSize, textSizeWithLetters);

          await tester.enterText(
            find.byType(CustomizationTextField).at(7),
            '',
          );
          for (var i = 0; i < textSizeStringWithLetters.length; i++) {
            tester.testTextInput.updateEditingValue(
              TextEditingValue(text: textSizeStringWithLetters[i]),
            );
          }
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.primaryButtonTextSize, textSizeWithLetters);

          await tester.enterText(
            find.byType(CustomizationTextField).at(8),
            '',
          );
          for (var i = 0; i < textSizeStringWithLetters.length; i++) {
            tester.testTextInput.updateEditingValue(
              TextEditingValue(text: textSizeStringWithLetters[i]),
            );
          }
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();
          expect(data.value.theme?.primaryButtonRadius, 0);

          expect(find.text(textSizeStringWithLetters), findsNothing);
        },
      );
      testWidgets(
        'pick text width and radius with more than 2 digits',
        (tester) async {
          await tester.pumpWidget(infoCommonCustomPanel);

          await tester.enterText(
            find.byType(CustomizationTextField).at(2),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          await tester.enterText(
            find.byType(CustomizationTextField).at(4),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          await tester.enterText(
            find.byType(CustomizationTextField).at(7),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          await tester.enterText(
            find.byType(CustomizationTextField).at(8),
            textSizeStringMoreThan2,
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pump();

          expect(find.text(textSizeStringMoreThan2), findsNothing);
        },
      );
    },
  );
}
