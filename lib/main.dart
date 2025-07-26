import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz/data/repositories/question_repository_impl.dart';
import 'quiz/domain/usecases/get_questions.dart';
import 'quiz/presentation/bloc/quiz_bloc.dart';
import 'quiz/presentation/pages/quiz_page.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = QuestionRepositoryImpl();
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => QuizBloc(getQuestions: GetQuestions(repository)),
        child: const QuizPage(),
      ),
    );
  }
}
