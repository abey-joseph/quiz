import 'package:equatable/equatable.dart';
import '../../domain/entities/question.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizQuestion extends QuizState {
  final Question question;
  final int currentIndex;
  final int total;
  final int? selectedIndex;
  final bool answered;

  const QuizQuestion({
    required this.question,
    required this.currentIndex,
    required this.total,
    this.selectedIndex,
    this.answered = false,
  });

  @override
  List<Object?> get props => [question, currentIndex, total, selectedIndex, answered];
}

class QuizFinished extends QuizState {
  final int score;
  final int total;

  const QuizFinished({required this.score, required this.total});

  @override
  List<Object?> get props => [score, total];
}
