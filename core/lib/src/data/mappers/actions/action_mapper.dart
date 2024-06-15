import 'package:activity_builder/src/domain/entities/actions/activity_action.dart';

abstract interface class ActionMapper<T extends ActivityAction> {
  Map<String, dynamic> toJson(T data);
  T fromJson(Map<String, dynamic> json);
}
