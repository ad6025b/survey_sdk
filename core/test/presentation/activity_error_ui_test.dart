import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/data/data_sources/filesystem_data_source_impl.dart';
import 'package:activity_builder/src/data/repositories/activity_data_repository_impl.dart';
import 'package:activity_builder/src/presentation/activity/activity_state.dart';
import 'package:activity_builder/src/presentation/activity_error/activity_error.dart';
import 'package:activity_builder/src/presentation/localization/activity_localizations_ext.dart';
import 'package:activity_builder/src/presentation/utils/activity_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../lib/src/presentation/activity/activity_cubit.dart';
import 'widget/app_tester.dart';

// ignore_for_file: unused_element

// ignore: prefer-match-file-name
class MockActivityDataRepository extends Mock
    implements ActivityDataRepositoryImpl {}

late String _activityLoadError;
late String _showDetails;
late String _closeDetails;
late String _damagedJson;
late String _next;
late String _textField;
late String _skip;

void _initializeLocalizations(BuildContext context) {
  _activityLoadError = context.localization.activityLoadError;
  _showDetails = context.localization.showErrorDetails;
  _closeDetails = context.localization.hideErrorDetails;
  _damagedJson = context.localization.damagedJson;
  _next = context.localization.next;
  _textField = context.localization.textField;
  _skip = context.localization.skip;
}

void main() async {
  const filePathToIncorrectJson = 'test/assets/test_activity_incorrect_data.json';

  final mockActivityDataRepository = MockActivityDataRepository();

  final activityDataSource = FilesystemDataSourceImpl();

  final dataWithIncorrectJson = await activityDataSource.getActivityData(
    filePathToIncorrectJson,
  );
  final dataWithIncorrectPath = await activityDataSource.getActivityData(
    'incorrect_path',
  );
  final errorsWithIncorrectJson = dataWithIncorrectJson.$2;
  final errorsWithIncorrectPath = dataWithIncorrectPath.$2;

  group(
    'activity error for incorrect JSON',
    () {
      late final Widget widgetWithIncorrectJson;

      final cubitWithIncorrectJson = ActivityCubit(mockActivityDataRepository);

      void emitForIncorrectJson() {
        cubitWithIncorrectJson.emit(
          ActivityErrorLoadState(
            providedErrors: errorsWithIncorrectJson,
            errorState: ActivityErrorState.collapsed,
          ),
        );
      }

      setUpAll(
        () {
          widgetWithIncorrectJson = AppTester(
            child: BlocBuilder<ActivityCubit, ActivityState>(
              bloc: cubitWithIncorrectJson,
              builder: (context, state) {
                _initializeLocalizations(context);

                return ActivityError(
                  providedErrors: errorsWithIncorrectJson,
                  onDetailsTap: cubitWithIncorrectJson.detailedError,
                  errorState: (state as ActivityErrorLoadState).errorState,
                );
              },
            ),
          );
        },
      );

      testWidgets(
        'should render correctly (with incorrect JSON)',
        (tester) async {
          emitForIncorrectJson();
          await tester.pumpWidget(widgetWithIncorrectJson);

          expect(find.text(_activityLoadError), findsOneWidget);
          expect(find.text(_showDetails), findsOneWidget);
        },
      );

      testWidgets(
        'should show stacktrace when button pressed (with incorrect JSON)',
        (tester) async {
          emitForIncorrectJson();
          tester.binding.platformDispatcher.textScaleFactorTestValue = 0.5;

          await tester.pumpWidget(widgetWithIncorrectJson);
          await tester.tap(find.text(_showDetails));
          await tester.pumpAndSettle();

          expect(find.text(_showDetails), findsNothing);
          expect(find.text(_closeDetails), findsOneWidget);
          expect(find.text(errorsWithIncorrectJson.first), findsOneWidget);
          expect(find.text(_damagedJson), findsOneWidget);
          tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
        },
      );

      testWidgets(
        'should show damaged JSON on details page',
        (tester) async {
          emitForIncorrectJson();
          final state = cubitWithIncorrectJson.state as ActivityErrorLoadState;

          tester.binding.platformDispatcher.textScaleFactorTestValue = 0.5;
          await tester.pumpWidget(widgetWithIncorrectJson);
          await tester.tap(find.text(_showDetails));
          await tester.pumpAndSettle();

          expect(find.text(_showDetails), findsNothing);
          expect(find.text(state.providedErrors.last), findsNothing);

          await tester.tap(find.text(_damagedJson));

          await tester.pumpAndSettle();

          expect(find.text(state.providedErrors.last), findsOneWidget);

          tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
        },
      );

      testWidgets(
        'should pop scope from details page correctly',
        (tester) async {
          emitForIncorrectJson();

          await tester.pumpWidget(widgetWithIncorrectJson);

          expect(
            (cubitWithIncorrectJson.state as ActivityErrorLoadState).errorState,
            ActivityErrorState.collapsed,
          );

          await tester.tap(find.text(_showDetails));
          await tester.pumpAndSettle();

          expect(
            (cubitWithIncorrectJson.state as ActivityErrorLoadState).errorState,
            ActivityErrorState.stacktrace,
          );

          final popScopeFinder = find.byType(WillPopScope);
          expect(popScopeFinder, findsOneWidget);
          final popScopeWidget = tester.widget<WillPopScope>(popScopeFinder);

          await popScopeWidget.onWillPop?.call();
          expect(
            (cubitWithIncorrectJson.state as ActivityErrorLoadState).errorState,
            ActivityErrorState.collapsed,
          );
        },
      );
    },
  );

  group(
    'activity error for incorrect filePath',
    () {
      late final Widget widgetWithIncorrectPath;
      final cubitWithIncorrectPath = ActivityCubit(mockActivityDataRepository);

      void emitForIncorrectPath() {
        cubitWithIncorrectPath.emit(
          ActivityErrorLoadState(
            providedErrors: errorsWithIncorrectPath,
            errorState: ActivityErrorState.collapsed,
          ),
        );
      }

      setUpAll(
        () {
          widgetWithIncorrectPath = AppTester(
            child: BlocBuilder<ActivityCubit, ActivityState>(
              bloc: cubitWithIncorrectPath,
              builder: (context, state) {
                _initializeLocalizations(context);

                return ActivityError(
                  providedErrors: errorsWithIncorrectPath,
                  onDetailsTap: cubitWithIncorrectPath.detailedError,
                  errorState: (state as ActivityErrorLoadState).errorState,
                );
              },
            ),
          );
        },
      );

      testWidgets(
        'should render correctly (with incorrect filePath)',
        (tester) async {
          emitForIncorrectPath();
          await tester.pumpWidget(widgetWithIncorrectPath);

          expect(find.text(_activityLoadError), findsOneWidget);
          expect(find.text(_showDetails), findsOneWidget);
        },
      );

      testWidgets(
        'should show stacktrace and exception (with incorrect filePath)',
        (tester) async {
          tester.binding.platformDispatcher.textScaleFactorTestValue = 0.5;
          emitForIncorrectPath();
          await tester.pumpWidget(widgetWithIncorrectPath);
          await tester.tap(find.text(_showDetails));
          await tester.pumpAndSettle();

          expect(find.text(_showDetails), findsNothing);
          expect(
            find.text(
              (cubitWithIncorrectPath.state as ActivityErrorLoadState)
                  .providedErrors
                  .first,
            ),
            findsOneWidget,
          );
          expect(find.text(_damagedJson), findsOneWidget);
          expect(
            find.text(
              (cubitWithIncorrectPath.state as ActivityErrorLoadState)
                  .providedErrors
                  .last,
            ),
            findsNothing,
          );
          await tester.tap(find.text(_damagedJson));
          await tester.pumpAndSettle();
          expect(
            find.text(
              (cubitWithIncorrectPath.state as ActivityErrorLoadState)
                  .providedErrors
                  .last,
            ),
            findsOneWidget,
          );

          tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
        },
      );
      testWidgets(
        'should pop scope from details page correctly',
        (tester) async {
          emitForIncorrectPath();

          await tester.pumpWidget(widgetWithIncorrectPath);

          expect(
            (cubitWithIncorrectPath.state as ActivityErrorLoadState).errorState,
            ActivityErrorState.collapsed,
          );

          await tester.tap(find.text(_showDetails));
          await tester.pumpAndSettle();

          expect(
            (cubitWithIncorrectPath.state as ActivityErrorLoadState).errorState,
            ActivityErrorState.stacktrace,
          );

          final popScopeFinder = find.byType(WillPopScope);
          expect(popScopeFinder, findsOneWidget);
          final popScopeWidget = tester.widget<WillPopScope>(popScopeFinder);

          await popScopeWidget.onWillPop?.call();
          expect(
            (cubitWithIncorrectPath.state as ActivityErrorLoadState).errorState,
            ActivityErrorState.collapsed,
          );
        },
      );
    },
  );
}
