import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';
import '../widgets/option_card.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizInitial) {
            context.read<QuizBloc>().add(StartQuiz());
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizQuestion) {
            final question = state.question;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${state.currentIndex + 1} / ${state.total}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    question.text,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < question.options.length; i++)
                    OptionCard(
                      text: question.options[i],
                      onTap: () => context.read<QuizBloc>().add(SelectOption(i)),
                      color: state.answered
                          ? i == question.answerIndex
                              ? Colors.green
                              : i == state.selectedIndex
                                  ? Colors.red
                                  : null
                          : null,
                    ),
                  const SizedBox(height: 20),
                  if (state.answered)
                    ElevatedButton(
                      onPressed: () => context.read<QuizBloc>().add(NextQuestion()),
                      child: Text(
                        state.currentIndex == state.total - 1 ? 'Finish' : 'Next',
                      ),
                    ),
                ],
              ),
            );
          } else if (state is QuizFinished) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your score: ${state.score} / ${state.total}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<QuizBloc>().add(RestartQuiz()),
                    child: const Text('Restart Quiz'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
