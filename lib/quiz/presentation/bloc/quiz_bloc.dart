import 'package:bloc/bloc.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/get_questions.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestions getQuestions;
  late final List<Question> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  QuizBloc({required this.getQuestions}) : super(QuizInitial()) {
    on<StartQuiz>(_onStartQuiz);
    on<SelectOption>(_onSelectOption);
    on<NextQuestion>(_onNextQuestion);
    on<RestartQuiz>(_onRestartQuiz);
  }

  void _onStartQuiz(StartQuiz event, Emitter<QuizState> emit) {
    _questions = getQuestions();
    _currentIndex = 0;
    _score = 0;
    _selectedIndex = null;
    _answered = false;
    emit(QuizQuestion(
      question: _questions[_currentIndex],
      currentIndex: _currentIndex,
      total: _questions.length,
    ));
  }

  void _onSelectOption(SelectOption event, Emitter<QuizState> emit) {
    if (_answered || _currentIndex >= _questions.length) return;
    _selectedIndex = event.index;
    _answered = true;
    if (event.index == _questions[_currentIndex].answerIndex) {
      _score++;
    }
    emit(QuizQuestion(
      question: _questions[_currentIndex],
      currentIndex: _currentIndex,
      total: _questions.length,
      selectedIndex: _selectedIndex,
      answered: _answered,
    ));
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (_currentIndex >= _questions.length - 1) {
      emit(QuizFinished(score: _score, total: _questions.length));
      return;
    }
    _currentIndex++;
    _selectedIndex = null;
    _answered = false;
    emit(QuizQuestion(
      question: _questions[_currentIndex],
      currentIndex: _currentIndex,
      total: _questions.length,
    ));
  }

  void _onRestartQuiz(RestartQuiz event, Emitter<QuizState> emit) {
    add(StartQuiz());
  }
}
