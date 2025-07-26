import '../entities/question.dart';

abstract class QuestionRepository {
  List<Question> getQuestions();
}
