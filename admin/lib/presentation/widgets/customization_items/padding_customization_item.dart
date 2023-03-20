import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_admin/presentation/utils/colors.dart';
import 'package:survey_admin/presentation/utils/constants/app_dimensions.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';

class PaddingCustomizationItem extends StatefulWidget {
  final double initialHorizontalPadding;
  final double initialVerticalPadding;
  final ValueChanged<double> onHorizontalPaddingChange;
  final ValueChanged<double> onVerticalPaddingChange;

  const PaddingCustomizationItem({
    required this.initialHorizontalPadding,
    required this.initialVerticalPadding,
    required this.onHorizontalPaddingChange,
    required this.onVerticalPaddingChange,
    super.key,
  });

  @override
  State<PaddingCustomizationItem> createState() =>
      _PaddingCustomizationItemState();
}

class _PaddingCustomizationItemState extends State<PaddingCustomizationItem> {
  final horizontalPaddingFocusNode = FocusNode();
  final verticalPaddingFocusNode = FocusNode();
  late double horizontalPadding;
  late double verticalPadding;

  @override
  void initState() {
    super.initState();

    horizontalPadding = widget.initialHorizontalPadding;
    verticalPadding = widget.initialVerticalPadding;
    horizontalPaddingFocusNode.addListener(() {
      if (!horizontalPaddingFocusNode.hasFocus) {
        widget.onHorizontalPaddingChange(horizontalPadding);
      }
    });
    verticalPaddingFocusNode.addListener(() {
      if (!verticalPaddingFocusNode.hasFocus) {
        widget.onVerticalPaddingChange(verticalPadding);
      }
    });
  }

  @override
  void dispose() {
    horizontalPaddingFocusNode.dispose();
    verticalPaddingFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PaddingItem(
          isHorizontal: true,
          focusNode: horizontalPaddingFocusNode,
          initialValue: horizontalPadding.toString(),
          onChanged: (value) =>
              setState(() => horizontalPadding = double.parse(value)),
        ),
        _PaddingItem(
          isHorizontal: false,
          focusNode: verticalPaddingFocusNode,
          initialValue: verticalPadding.toString(),
          onChanged: (value) =>
              setState(() => verticalPadding = double.parse(value)),
        ),
      ],
    );
  }
}

class _PaddingItem extends StatelessWidget {
  final bool isHorizontal;
  final FocusNode focusNode;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _PaddingItem({
    required this.focusNode,
    required this.initialValue,
    required this.onChanged,
    required this.isHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: isHorizontal
                  ? const Border.symmetric(
                      horizontal: BorderSide(),
                    )
                  : const Border.symmetric(
                      vertical: BorderSide(),
                    ),
              color: AppColors.white,
            ),
            width: AppDimensions.sizeM,
            height: AppDimensions.sizeM,
          ),
          Container(
            margin: const EdgeInsets.only(left: AppDimensions.marginXS),
            width: AppDimensions.sizeXL,
            child: CustomizationTextField(
              focusNode: focusNode,
              initialValue: initialValue,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
