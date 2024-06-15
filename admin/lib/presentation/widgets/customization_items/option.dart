import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String option;
  final VoidCallback onDelete;

  const Option({
    required this.option,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.fiber_manual_record,
          size: ActivityDimensions.sizeS,
        ),
        const SizedBox(width: ActivityDimensions.margin2XS),
        Expanded(
          child: Text(
            option,
            style: context.theme.textTheme.bodyLarge,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.close,
            size: ActivityDimensions.sizeM,
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
