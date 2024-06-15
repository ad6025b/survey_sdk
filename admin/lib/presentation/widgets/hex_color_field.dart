import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HexColorField extends StatelessWidget {
  final TextEditingController colorTextController;
  final ValueChanged<Color> onColorPicked;

  const HexColorField({
    required this.colorTextController,
    required this.onColorPicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(ActivityDimensions.margin2XS),
        child: TextField(
          controller: colorTextController,
          style: const TextStyle(fontSize: ActivityFonts.sizeL),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          inputFormatters: [
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
          ],
          onChanged: (str) => onColorPicked(colorFromHex(str)!),
        ),
      ),
    );
  }
}
