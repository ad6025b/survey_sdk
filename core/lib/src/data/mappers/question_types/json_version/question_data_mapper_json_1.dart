import 'package:activity_builder/src/data/mappers/question_types/question_data_mapper.dart';

abstract class QuestionDataMapperJson1<T> extends QuestionDataMapper<T> {
  @override
  int get jsonVersion => 1;
}
