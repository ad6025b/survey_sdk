import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_items/switch_customization_item.dart';
import 'package:survey_sdk/activity_sdk.dart';

class SecondaryButtonCustomizationItem extends StatefulWidget {
  final void Function({required bool isShown, required String text}) onChanged;
  final String initialText;
  final bool isShown;

  const SecondaryButtonCustomizationItem({
    required this.onChanged,
    required this.isShown,
    this.initialText = '',
    super.key,
  });

  @override
  State<SecondaryButtonCustomizationItem> createState() =>
      _SecondaryButtonCustomizationItemState();
}

class _SecondaryButtonCustomizationItemState
    extends State<SecondaryButtonCustomizationItem> {
  late bool _isShown;
  late String _text;

  @override
  void initState() {
    super.initState();

    _isShown = widget.isShown;
    _text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchCustomizationItem(
          title: context.localization.secondaryButton,
          initialValue: _isShown,
          onChanged: (isToggled) {
            setState(() => _isShown = isToggled);
            widget.onChanged(isShown: _isShown, text: _text);
          },
        ),
        AnimatedSize(
          duration: ActivityDurations.customizationItemDuration,
          child: _isShown
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: ActivityDimensions.marginM,
                  ),
                  child: CustomizationTextField(
                    initialValue: widget.initialText,
                    onChanged: (text) {
                      if (text != null) {
                        setState(() => _text = text);
                      }
                      widget.onChanged(isShown: _isShown, text: _text);
                    },
                    decoration: InputDecoration(
                      hintText: context.localization.enterText,
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
