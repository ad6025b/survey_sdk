import 'package:flutter/material.dart';
import 'package:survey_sdk/activity_sdk.dart';

/// This controller need to navigation on activity and save answer.
/// Function [onNext] navigate to next page and save answer on last page.
/// Function [onBack] navigate to previous page.
class ActivityController {
  /// The controller responsible for managing the pages in the activity.
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  void addListener(VoidCallback listener) {
    _pageController.addListener(listener);
  }

  void onNext() {
    _pageController.nextPage(
      duration: ActivityDurations.panelSwitchingDuration,
      curve: Curves.linear,
    );
  }

  /// Animates the [_pageController] to navigate to the specified [index].
  /// This method smoothly transitions to the desired page.
  void animateTo(int index) {
    if (_pageController.hasClients && _pageController.page != null) {
      _pageController.animateToPage(
        index,
        duration: ActivityDurations.animateToSpecificPageDuration,
        curve: Curves.easeOutCubic,
      );
    }
  }

  /// Moves the [_pageController] to the previous page, effectively allowing the
  /// user to navigate back within the activity.
  void onBack() {
    _pageController.previousPage(
      duration: ActivityDurations.panelSwitchingDuration,
      curve: Curves.linear,
    );
  }

  void dispose() {
    _pageController.dispose();
  }
}
