import '../../quiz/domain/entities/question.dart';
import '../../quiz/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  @override
  List<Question> getQuestions() {
    return const [
      Question(
        text: 'What is the capital of France?',
        options: ['Berlin', 'London', 'Paris', 'Rome'],
        answerIndex: 2,
      ),
      Question(
        text: 'Which planet is known as the Red Planet?',
        options: ['Mars', 'Venus', 'Jupiter', 'Saturn'],
        answerIndex: 0,
      ),
      Question(
        text: 'Who wrote Hamlet?',
        options: ['Charles Dickens', 'William Shakespeare', 'Mark Twain', 'Ernest Hemingway'],
        answerIndex: 1,
      ),
      Question(
        text: 'Which ocean is the largest?',
        options: ['Atlantic', 'Pacific', 'Indian', 'Arctic'],
        answerIndex: 1,
      ),
      Question(
        text: 'What is the square root of 64?',
        options: ['6', '7', '8', '9'],
        answerIndex: 2,
      ),
    ];
  }
}
