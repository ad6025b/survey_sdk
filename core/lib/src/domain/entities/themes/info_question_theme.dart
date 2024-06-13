import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:survey_sdk/src/presentation/utils/utils.dart';

/// The [InfoQuestionTheme] class represents the visual styling and appearance
/// for an info question options.
///
/// This class extends the [ThemeExtension] class and implements the
/// [EquatableMixin] to provide equality checks and comparison methods.
class InfoQuestionTheme extends ThemeExtension<InfoQuestionTheme>
    with EquatableMixin {
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
  /// Default value is [Colors.black].
  final double secondaryButtonTextSize;

  /// Border radius of the secondary button.
  /// Default value is [10.0].
  final double secondaryButtonRadius;

  @override
  List<Object?> get props => [
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

  const InfoQuestionTheme({
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

  /// Creates a common instance of [InfoQuestionTheme].
  ///
  /// The [InfoQuestionTheme.common] constructor is a convenience constructor
  /// that creates a common instance of [InfoQuestionTheme] with predefined
  /// values.
  const InfoQuestionTheme.common()
      : this(
          fill: ActivityColors.white,
          titleColor: ActivityColors.black,
          titleSize: ActivityFonts.sizeL,
          subtitleColor: ActivityColors.black,
          subtitleSize: ActivityFonts.sizeS,
          primaryButtonFill: ActivityColors.black,
          primaryButtonTextColor: ActivityColors.white,
          primaryButtonTextSize: ActivityFonts.sizeS,
          primaryButtonRadius: ActivityDimensions.circularRadiusS,
          secondaryButtonFill: ActivityColors.black,
          secondaryButtonTextColor: ActivityColors.white,
          secondaryButtonTextSize: ActivityFonts.sizeS,
          secondaryButtonRadius: ActivityDimensions.circularRadiusS,
        );

  @override
  InfoQuestionTheme copyWith({
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
    return InfoQuestionTheme(
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
      secondaryButtonFill: secondaryButtonFill ?? this.secondaryButtonFill,
      secondaryButtonTextColor:
          secondaryButtonTextColor ?? this.secondaryButtonTextColor,
      secondaryButtonTextSize:
          secondaryButtonTextSize ?? this.secondaryButtonTextSize,
      secondaryButtonRadius:
          secondaryButtonRadius ?? this.secondaryButtonRadius,
    );
  }

  /// Linearly interpolates between two instances of [InfoQuestionTheme].
  ///
  /// The [lerp] method calculates the intermediate state between two instances
  /// of [InfoQuestionTheme] based on a given interpolation factor [t].
  ///
  /// If the `other` instance is not of type [InfoQuestionTheme], the method
  /// returns the current instance without any interpolation.
  @override
  InfoQuestionTheme lerp(
    covariant InfoQuestionTheme? other,
    double t,
  ) {
    if (other is! InfoQuestionTheme) {
      return this;
    }
    return InfoQuestionTheme(
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
