import 'package:survey_sdk/src/domain/entities/actions/main_button_action/main_button_action.dart';

class GoToAction extends MainButtonAction {
  final int questionIndex;

  GoToAction({required this.questionIndex});
}
