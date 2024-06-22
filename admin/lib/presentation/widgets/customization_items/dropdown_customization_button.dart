import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:survey_admin/presentation/utils/utils.dart';

class DropdownCustomizationButton<T> extends StatefulWidget {
  final T? value;
  final List<DropdownCustomizationItem<T>> items;
  final bool withColor;

  const DropdownCustomizationButton({
    this.value,
    required this.items,
    required this.withColor,
    super.key,
  });

  @override
  State<DropdownCustomizationButton<T>> createState() =>
      _DropdownCustomizationButtonState<T>();
}

class _DropdownCustomizationButtonState<T>
    extends State<DropdownCustomizationButton<T>>
    with TickerProviderStateMixin {
  late bool _isExpanded = false;
  late final AnimationController _iconAnimationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    const tweenBegin = 0.0;
    const tweenEnd = 0.5;

    _isExpanded = false;
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: ActivityDurations.customizationItemDuration,
    );
    // ignore: prefer_int_literals
    _animation = Tween(begin: tweenBegin, end: tweenEnd).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DropdownCustomizationButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isExpanded) {
      _iconAnimationController.reverse();
    }
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    T effectiveValue = widget.value ?? widget.items.first.value;
    return DecoratedBox(
      decoration: widget.withColor
          ? BoxDecoration(
              color: _isExpanded
                  ? ActivityColors.dropdownMenuBackground
                  : ActivityColors.whitePrimaryBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(ActivityDimensions.circularRadiusS),
              ),
            )
          : const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: ActivityDimensions.margin2XS,
              horizontal: ActivityDimensions.marginM,
            ),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.items
                      .where((element) => element.value == effectiveValue)
                      .first
                      .child,
                  RotationTransition(
                    turns: _animation,
                    child: SvgPicture.asset(AppAssets.arrowIcon),
                  ),
                ],
              ),
              onTap: () {
                _isExpanded
                    ? _iconAnimationController.reverse()
                    : _iconAnimationController.forward();
                setState(() => _isExpanded = !_isExpanded);
              },
            ),
          ),
          AnimatedSize(
            duration: ActivityDurations.customizationItemDuration,
            child: _isExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.items
                        .where((element) => element.value != effectiveValue)
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class DropdownCustomizationItem<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final ValueChanged<T>? onChange;

  const DropdownCustomizationItem({
    required this.child,
    required this.value,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        InkWell(
          onTap: () => onChange?.call(value),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: ActivityDimensions.margin2XS,
                  horizontal: ActivityDimensions.marginM,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
