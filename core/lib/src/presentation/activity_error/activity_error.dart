import 'package:flutter/material.dart';
import 'package:activity_builder/src/presentation/localization/activity_localizations_ext.dart';
import 'package:activity_builder/src/presentation/utils/utils.dart';

class ActivityError extends StatelessWidget {
  final List<String> providedErrors;
  final ValueChanged<ActivityErrorState> onDetailsTap;
  final ActivityErrorState errorState;

  const ActivityError({
    required this.providedErrors,
    required this.onDetailsTap,
    required this.errorState,
    super.key,
  });

  ActivityErrorState get _selectableErrorState => switch (errorState) {
        ActivityErrorState.collapsed => ActivityErrorState.stacktrace,
        ActivityErrorState.stacktrace => ActivityErrorState.collapsed,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(
          builder: (_) => switch (errorState) {
            ActivityErrorState.collapsed => _ActivityErrorTitle(
                errorTitle: context.localization.activityLoadError,
              ),
            ActivityErrorState.stacktrace => _StacktraceBody(
                providedErrors: providedErrors,
                onDetailsTap: onDetailsTap,
              ),
          },
        ),
        TextButton(
          onPressed: () => onDetailsTap(_selectableErrorState),
          child: Text(
            errorState == ActivityErrorState.stacktrace
                ? context.localization.hideErrorDetails
                : context.localization.showErrorDetails,
          ),
        ),
      ],
    );
  }
}

class _StacktraceBody extends StatelessWidget {
  final List<String> providedErrors;
  final ValueChanged<ActivityErrorState> onDetailsTap;

  const _StacktraceBody({
    required this.providedErrors,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onDetailsTap(ActivityErrorState.collapsed);
        return false;
      },
      child: Expanded(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: ActivityDimensions.marginS,
          ),
          children: [
            _ActivityErrorTitle(
              errorTitle: providedErrors.first,
            ),
            ExpansionTile(
              title: Text(context.localization.damagedJson),
              children: [
                Text(providedErrors.last),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityErrorTitle extends StatelessWidget {
  final String errorTitle;

  const _ActivityErrorTitle({required this.errorTitle});

  @override
  Widget build(BuildContext context) {
    // TODO(dev): May be we should to have text themes (h1, h2, etc.)
    return Align(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ActivityDimensions.margin2XS,
        ),
        child: Text(
          errorTitle,
          style: const TextStyle(
            color: ActivityColors.black,
            fontWeight: ActivityFonts.weightBold,
            fontSize: ActivityFonts.sizeXL,
          ),
        ),
      ),
    );
  }
}
