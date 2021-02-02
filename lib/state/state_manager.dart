import 'package:flutter_quiz_app/database/category_provider.dart';
import 'package:flutter_quiz_app/database/question_provider.dart';
import 'package:flutter_quiz_app/model/user_answer.dart';
import 'package:flutter_riverpod/all.dart';

final categoryListProvider = StateNotifierProvider((ref) => CategoryList([]));
final questionCategoryState = StateProvider((ref) => Category());
final isTestMode = StateProvider((ref) => false);
final currentReadPage = StateProvider((ref) => 0);
final userAnswerSelected = StateProvider((ref) => new UserAnswer());
final isEnableShowAnswer = StateProvider((ref) => false);
final userListAnswer = StateProvider((ref) => List<UserAnswer>());
final userViewQuestionState = StateProvider((ref) => new Question());