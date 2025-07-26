import '../entities/question.dart';
import '../repositories/question_repository.dart';

class GetQuestions {
  final QuestionRepository repository;

  const GetQuestions(this.repository);

  List<Question> call() => repository.getQuestions();
}
