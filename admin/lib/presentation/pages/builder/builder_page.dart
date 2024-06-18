import 'package:activity_builder/activity_sdk.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_admin/presentation/app/di/injector.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/pages/builder/builder_cubit.dart';
import 'package:survey_admin/presentation/pages/builder/builder_state.dart';
import 'package:survey_admin/presentation/widgets/builder_page/phone_view.dart';
import 'package:survey_admin/presentation/widgets/builder_page/question_list.dart';
import 'package:survey_admin/presentation/widgets/editor_bar.dart';
import 'package:survey_admin/presentation/widgets/export_floating_window.dart';

class BuilderPage extends StatelessWidget {
  const BuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => i.get<BuilderCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content>
    with SingleTickerProviderStateMixin {
  late final ActivityController _activityController;
  late final TabController _tabController;
  static const tabLength = 2;

  BuilderCubit cubit(BuildContext context) => context.read<BuilderCubit>();

  @override
  void initState() {
    super.initState();
    _activityController = ActivityController()..addListener(_onChangePage);
    _tabController = TabController(vsync: this, length: tabLength);
    initCommonData(context);
  }

  void _onChangePage() {
    final cubit = this.cubit(context);
    final questions = cubit.state.activityData.questions;
    final index = _activityController.pageController.page;
    final question =
        index != null && index % 1 == 0 ? questions[index.toInt()] : null;

    if (question != null) {
      cubit.select(question);
    }
  }

  Future<void> _showImportDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(context.localization.emptyDataMessage),
          actions: <Widget>[
            TextButton(
              child: Text(
                context.localization.ok,
                style: const TextStyle(
                  color: ActivityColors.white,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  QuestionData? _editableQuestion(BuilderState state) {
    if (state is EditQuestionBuilderState) {
      return state.activityData.questions
          .firstWhereOrNull((q) => q.index == state.selectedIndex);
    } else if (state is PreviewQuestionBuilderState) {
      return state.selectedQuestion;
    } else {
      return null;
    }
  }

  int? _selectedIndex(BuilderState state) {
    if (state is EditQuestionBuilderState) {
      return state.selectedIndex - 1;
    } else if (state is PreviewQuestionBuilderState) {
      final index = state.selectedQuestion?.index;
      return index != null ? index - 1 : null;
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _activityController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = this.cubit(context);
    return BlocConsumer<BuilderCubit, BuilderState>(
      listener: (_, newState) {
        if (newState is ImportErrorActivityDataBuilderState) {
          _showImportDialog();
        }
        final selected =
            newState is EditQuestionBuilderState ? newState.selectedIndex : 0;
        if (selected != 0) {
          _activityController.animateTo(selected - 1);
        }
      },
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            title: _BuilderPageTabBar(
              tabController: _tabController,
              onTapEditMode: cubit.openEditMode,
              onTapPreviewMode: cubit.openPreviewMode,
            ),
            actions: [
              _ImportButton(
                onImportPressed: () {
                  cubit.importData();
                  _tabController.animateTo(0);
                  cubit.openEditMode();
                },
              ),
              _ExportButton(
                isButtonActive: cubit.state.activityData.questions.isEmpty,
                downloadActivityData: cubit.downloadActivityData,
                copyActivityData: cubit.copyActivityData,
              ),
            ],
            centerTitle: true,
          ),
          body: Row(
            children: [
              QuestionList(
                isEditMode: state is EditQuestionBuilderState,
                onDelete: cubit.deleteQuestionData,
                onSelect: cubit.select,
                onAdd: cubit.addQuestionData,
                data: cubit.state.activityData,
                onUpdate: cubit.updateQuestions,
                selectedIndex: _selectedIndex(state),
                onDataUpdate: cubit.updateCommonTheme,
              ),
              Expanded(
                child: PhoneView(
                  child: Activity(
                    activityData: state.activityData,
                    controller: _activityController,
                    saveAnswer: state.saveAnswer ?? false,
                    onFinish: (answers) => answers.forEach((key, value) {
                      debugPrint('Key: $key, Value: $value');
                    }),
                  ),
                ),
              ),
              EditorBar(
                isEditMode: state is EditQuestionBuilderState,
                onChange: cubit.updateQuestionData,
                editableQuestion: _editableQuestion(state),
                questionsAmount: state.activityData.questions.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuilderPageTabBar extends StatelessWidget {
  final TabController tabController;
  final VoidCallback onTapEditMode;
  final VoidCallback onTapPreviewMode;

  const _BuilderPageTabBar({
    required this.tabController,
    required this.onTapEditMode,
    required this.onTapPreviewMode,
  });

  @override
  Widget build(BuildContext context) {
    const previewTabIndex = 1;

    return SizedBox(
      width: ActivityDimensions.tabBarWidth,
      child: TabBar(
        controller: tabController,
        tabs: [
          Tab(text: context.localization.create),
          Tab(text: context.localization.preview),
        ],
        padding: const EdgeInsets.only(right: ActivityDimensions.tabBarPadding),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(),
          insets: EdgeInsets.symmetric(
            horizontal: ActivityDimensions.margin4XL + ActivityDimensions.sizeM,
          ),
        ),
        labelStyle: context.theme.textTheme.titleMedium
            ?.copyWith(fontWeight: ActivityFonts.weightBold),
        onTap: (tabIndex) =>
            tabIndex == previewTabIndex ? onTapPreviewMode() : onTapEditMode(),
      ),
    );
  }
}

class _ImportButton extends StatelessWidget {
  final VoidCallback onImportPressed;

  const _ImportButton({required this.onImportPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: ActivityDimensions.margin2XS,
        right: ActivityDimensions.margin2XL,
        bottom: ActivityDimensions.margin2XS,
      ),
      child: OutlinedButton(
        onPressed: onImportPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ActivityDimensions.margin3XL,
          ),
          child: Text(
            context.localization.import,
            style: context.theme.textTheme.labelLarge?.copyWith(
              fontFamily: ActivityFonts.karla,
              color: ActivityColors.text,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  final bool isButtonActive;
  final VoidCallback downloadActivityData;
  final VoidCallback copyActivityData;

  const _ExportButton({
    required this.isButtonActive,
    required this.downloadActivityData,
    required this.copyActivityData,
  });

  Future<void> _errorExportDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(context.localization.emptyQuestionMessage),
          actions: <Widget>[
            TextButton(
              child: Text(
                context.localization.ok,
                style: const TextStyle(
                  color: ActivityColors.white,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: ActivityDimensions.margin2XS,
        right: ActivityDimensions.margin3XL,
        bottom: ActivityDimensions.margin2XS,
      ),
      child: TextButton(
        onPressed: isButtonActive
            ? () => _errorExportDialog(context)
            : () {
                showExportFloatingWindow(
                  context,
                  onDownloadPressed: downloadActivityData,
                  onCopy: copyActivityData,
                );
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ActivityDimensions.margin3XL,
          ),
          child: Text(
            context.localization.export,
            style: context.theme.textTheme.labelLarge?.copyWith(
              fontFamily: ActivityFonts.karla,
              color: ActivityColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
