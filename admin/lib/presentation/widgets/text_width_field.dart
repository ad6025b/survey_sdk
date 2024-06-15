import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextWidthField extends StatelessWidget {
  final TextEditingController textWidthTextController;
  final ValueChanged<int> onTextWidthPicked;

  const TextWidthField({
    required this.textWidthTextController,
    required this.onTextWidthPicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(ActivityDimensions.margin2XS),
        child: TextField(
          controller: textWidthTextController,
          style: const TextStyle(fontSize: ActivityFonts.sizeL),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d{1,2}')),
          ],
          onSubmitted: (str) => onTextWidthPicked(int.parse(str)),
        ),
      ),
    );
  }
}
