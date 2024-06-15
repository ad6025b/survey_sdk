import 'dart:ui';

import 'package:activity_builder/activity_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const _titleSize = 16.0;
const _subtitleSize = 12.0;
const _buttonTextSize = 12.0;
const _buttonRadius = 10.0;

/// The [ChoiceQuestionTheme] class represents the visual styling and appearance
/// of options in a choice question.
///
/// This class extends the [ThemeExtension] class and implements the
/// [EquatableMixin] to provide equality checks and comparison methods.
class ChoiceQuestionTheme extends ThemeExtension<ChoiceQuestionTheme>
    with EquatableMixin {
  /// Color of the active radio or checkbox option.
  /// Default value is [Colors.black].
  final Color activeColor;

  /// Color of the inactive radio or checkbox option.
  /// Default value is [Colors.grey].
  final Color inactiveColor;

  /// Background color of the choice page.
  /// Default value is [Colors.white].
  final Color fill;

  /// Color of the title text.
  /// Default value is [Colors.black].
  final Color titleColor;

  /// Font size of the title text.
  /// Default value is [16.0].
  final double titleSize;

  /// Color of the subtitle text.
  /// Default value is [Colors.black].
  final Color subtitleColor;

  /// Font size of the subtitle text.
  /// Default value is [12.0].
  final double subtitleSize;

  /// Background color of the primary button.
  /// Default value is [Colors.black].
  final Color primaryButtonFill;

  /// Text color of the primary button.
  /// Default value is [Colors.white].
  final Color primaryButtonTextColor;

  /// Font size of the text displayed on the primary button.
  /// Default value is [12.0].
  final double primaryButtonTextSize;

  /// Border radius of the primary button.
  /// Default value is [10.0].
  final double primaryButtonRadius;

  /// Background color of the secondary button.
  /// Default value is [Colors.black].
  final Color secondaryButtonFill;

  /// Text color of the secondary button.
  /// Default value is [Colors.white].
  final Color secondaryButtonTextColor;

  /// Font size of the text displayed on the secondary button.
  /// Default value is [12.0].
  final double secondaryButtonTextSize;

  /// Border radius of the secondary button.
  /// Default value is [10.0].
  final double secondaryButtonRadius;

  @override
  List<Object?> get props => [
        activeColor,
        inactiveColor,
        fill,
        titleColor,
        titleSize,
        subtitleColor,
        subtitleSize,
        primaryButtonFill,
        primaryButtonTextColor,
        primaryButtonTextSize,
        primaryButtonRadius,
        secondaryButtonFill,
        secondaryButtonTextColor,
        secondaryButtonTextSize,
        secondaryButtonRadius,
      ];

  const ChoiceQuestionTheme({
    required this.activeColor,
    required this.inactiveColor,
    required this.fill,
    required this.titleColor,
    required this.titleSize,
    required this.subtitleColor,
    required this.subtitleSize,
    required this.primaryButtonFill,
    required this.primaryButtonTextColor,
    required this.primaryButtonTextSize,
    required this.primaryButtonRadius,
    required this.secondaryButtonFill,
    required this.secondaryButtonTextColor,
    required this.secondaryButtonTextSize,
    required this.secondaryButtonRadius,
  });

  /// Creates a common instance of [ChoiceQuestionTheme].
  ///
  /// The [ChoiceQuestionTheme.common] constructor is a convenience constructor
  /// that creates a common instance of [ChoiceQuestionTheme] with predefined
  /// values.
  const ChoiceQuestionTheme.common()
      : this(
          activeColor: ActivityColors.black,
          inactiveColor: ActivityColors.grey,
          fill: ActivityColors.white,
          titleColor: ActivityColors.black,
          titleSize: _titleSize,
          subtitleColor: ActivityColors.black,
          subtitleSize: _subtitleSize,
          primaryButtonFill: ActivityColors.black,
          primaryButtonTextColor: ActivityColors.white,
          primaryButtonTextSize: _buttonTextSize,
          primaryButtonRadius: _buttonRadius,
          secondaryButtonFill: ActivityColors.black,
          secondaryButtonTextColor: ActivityColors.white,
          secondaryButtonTextSize: _buttonTextSize,
          secondaryButtonRadius: _buttonRadius,
        );

  @override
  ChoiceQuestionTheme copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? fill,
    Color? titleColor,
    double? titleSize,
    Color? subtitleColor,
    double? subtitleSize,
    Color? primaryButtonFill,
    Color? primaryButtonTextColor,
    double? primaryButtonTextSize,
    double? primaryButtonRadius,
    Color? secondaryButtonFill,
    Color? secondaryButtonTextColor,
    double? secondaryButtonTextSize,
    double? secondaryButtonRadius,
  }) {
    return ChoiceQuestionTheme(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      fill: fill ?? this.fill,
      titleColor: titleColor ?? this.titleColor,
      titleSize: titleSize ?? this.titleSize,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      subtitleSize: subtitleSize ?? this.subtitleSize,
      primaryButtonFill: primaryButtonFill ?? this.primaryButtonFill,
      primaryButtonTextColor:
          primaryButtonTextColor ?? this.primaryButtonTextColor,
      primaryButtonTextSize:
          primaryButtonTextSize ?? this.primaryButtonTextSize,
      primaryButtonRadius: primaryButtonRadius ?? this.primaryButtonRadius,
      secondaryButtonFill: secondaryButtonFill ?? this.primaryButtonFill,
      secondaryButtonTextColor:
          secondaryButtonTextColor ?? this.secondaryButtonTextColor,
      secondaryButtonTextSize:
          secondaryButtonTextSize ?? this.secondaryButtonTextSize,
      secondaryButtonRadius:
          secondaryButtonRadius ?? this.secondaryButtonRadius,
    );
  }

  /// Linearly interpolates between two instances of [ChoiceQuestionTheme].
  ///
  /// The [lerp] method calculates the intermediate state between two instances
  /// of [ChoiceQuestionTheme] based on a given interpolation factor [t].
  ///
  /// If the `other` instance is not of type [ChoiceQuestionTheme], the method
  /// returns the current instance without any interpolation.
  @override
  ChoiceQuestionTheme lerp(
    covariant ChoiceQuestionTheme? other,
    double t,
  ) {
    if (other is! ChoiceQuestionTheme) {
      return this;
    }
    return ChoiceQuestionTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      fill: Color.lerp(fill, other.fill, t)!,
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
      titleSize: lerpDouble(titleSize, other.titleSize, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      subtitleSize: lerpDouble(subtitleSize, other.subtitleSize, t)!,
      primaryButtonFill: Color.lerp(
        primaryButtonFill,
        other.primaryButtonFill,
        t,
      )!,
      primaryButtonTextColor: Color.lerp(
        primaryButtonTextColor,
        other.primaryButtonTextColor,
        t,
      )!,
      primaryButtonTextSize: lerpDouble(
        primaryButtonTextSize,
        other.primaryButtonTextSize,
        t,
      )!,
      primaryButtonRadius: lerpDouble(
        primaryButtonRadius,
        other.primaryButtonRadius,
        t,
      )!,
      secondaryButtonFill: Color.lerp(
        secondaryButtonFill,
        other.secondaryButtonFill,
        t,
      )!,
      secondaryButtonTextColor: Color.lerp(
        secondaryButtonTextColor,
        other.secondaryButtonTextColor,
        t,
      )!,
      secondaryButtonTextSize: lerpDouble(
        secondaryButtonTextSize,
        other.secondaryButtonTextSize,
        t,
      )!,
      secondaryButtonRadius: lerpDouble(
        secondaryButtonRadius,
        other.secondaryButtonRadius,
        t,
      )!,
    );
  }
}
