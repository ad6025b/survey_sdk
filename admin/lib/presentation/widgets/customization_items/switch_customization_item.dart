import 'package:flutter/material.dart';
import 'package:activity_builder/activity_sdk.dart';

class SwitchCustomizationItem extends StatelessWidget {
  final String title;
  final bool? initialValue;
  final ValueChanged<bool>? onChanged;

  const SwitchCustomizationItem({
    required this.title,
    this.initialValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.theme.textTheme.titleSmall,
        ),
        _CustomSwitch(
          initialValue: initialValue ?? false,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const _CustomSwitch({
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<_CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<_CustomSwitch> {
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();

    _isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => _isToggled = !_isToggled);
        widget.onChanged?.call(_isToggled);
      },
      child: AnimatedContainer(
        height: ActivityDimensions.switchHeight,
        width: ActivityDimensions.switchWidth,
        decoration: BoxDecoration(
          color: _isToggled
              ? ActivityColors.switchBackgroundActive
              : ActivityColors.switchBackgroundInactive,
          borderRadius: const BorderRadius.all(
            Radius.circular(ActivityDimensions.circularRadiusS),
          ),
        ),
        duration: ActivityDurations.customizationItemDuration,
        child: AnimatedAlign(
          alignment: _isToggled ? Alignment.centerRight : Alignment.centerLeft,
          duration: ActivityDurations.customizationItemDuration,
          child: Container(
            margin: const EdgeInsets.all(ActivityDimensions.margin3XS),
            width: ActivityDimensions.switchIndicatorWidth,
            decoration: const BoxDecoration(
              color: ActivityColors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(ActivityDimensions.circularRadiusM),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
