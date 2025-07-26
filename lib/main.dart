import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class Question {
  final String text;
  final List<String> options;
  final int answerIndex;

  const Question({
    required this.text,
    required this.options,
    required this.answerIndex,
  });
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> _questions = const [
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

  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  void _selectOption(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (index == _questions[_currentIndex].answerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      _selectedIndex = null;
      _answered = false;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _selectedIndex = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Finished')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your score: $_score / ${_questions.length}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restartQuiz,
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1} / ${_questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.text,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < question.options.length; i++)
              _buildOption(i, question.options[i]),
            const SizedBox(height: 20),
            if (_answered)
              ElevatedButton(
                onPressed: _currentIndex == _questions.length - 1
                    ? () => setState(() => _currentIndex++)
                    : _nextQuestion,
                child: Text(
                  _currentIndex == _questions.length - 1 ? 'Finish' : 'Next',
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index, String text) {
    Color? color;
    if (_answered) {
      if (index == _questions[_currentIndex].answerIndex) {
        color = Colors.green;
      } else if (index == _selectedIndex) {
        color = Colors.red;
      }
    }

    return Card(
      color: color,
      child: ListTile(
        title: Text(text),
        onTap: () => _selectOption(index),
      ),
    );
  }
}
