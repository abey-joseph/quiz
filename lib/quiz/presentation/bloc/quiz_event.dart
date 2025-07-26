import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class StartQuiz extends QuizEvent {}

class SelectOption extends QuizEvent {
  final int index;

  const SelectOption(this.index);

  @override
  List<Object?> get props => [index];
}

class NextQuestion extends QuizEvent {}

class RestartQuiz extends QuizEvent {}
