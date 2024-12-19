import 'package:flutter/material.dart';
import 'package:quiz_app/resultscreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOption; 
  bool _answered = false;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which programming language is used in Flutter?',
      'options': ['Dart', 'Java', 'JavaScript', 'Kotlin'],
      'answer': 1,
    },
    {
      'question': 'Who developed Flutter?',
      'options': ['Facebook', 'Microsoft', 'Google', 'Apple'],
      'answer': 2,
    },
    {
      'question':
          'Which of the following widgets is used to display text in Flutter?',
      'options': ['Text', 'Dart', 'TextWidget', 'Swift'],
      'answer': 1,
    },
    {
      'question': 'What is the default size of the Text widget in Flutter?',
      'options': ['16', '11', '20', '18'],
      'answer': 1,
    },
    {
      'question': 'What is the role of a Scaffold widget?',
      'options': [
        'State management',
        'Provides app structure',
        'Navigation',
        'Animation'
      ],
      'answer': 1,
    },
    {
      'question': 'What does the hot reload feature do?',
      'options': [
        'Restart the app',
        'Update code without losing state',
        'Clear app cache',
        'Debug the app'
      ],
      'answer': 1,
    },
    {
      'question':
          'Which of the following is used to handle user input in Flutter?',
      'options': ['pubspec.yaml', 'main.dart', 'index.html', 'config.json'],
      'answer': 0,
    },
    {
      'question': 'What is a State in Flutter?',
      'options': [
        'Manages app data that changes over time',
        'Defines app routes',
        'Describes app UI',
        'Handles animations'
      ],
      'answer': 0,
    },
    {
      'question': 'What is the purpose of the main() function in Flutter?',
      'options': [
        'Runs the app',
        'Compiles the code',
        'Initializes database',
        'Connects to APIs'
      ],
      'answer': 0,
    },
    {
      'question': 'Which widget is used to navigate between screens?',
      'options': ['Navigator', 'Scaffold', 'AppBar', 'Container'],
      'answer': 0,
    },
  ];

  
  void _selectOption(int selectedOption) {
    setState(() {
      _selectedOption = selectedOption;
      _answered = true; 
    });

   
    if (_selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }
  }

 
  void _nextQuestion() {
    setState(() {
      _answered = false; 
      _selectedOption = null;
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex == _questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(score: _score, total: _questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz'),
        backgroundColor: const Color.fromARGB(255, 100, 198, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            
            ..._questions[_currentQuestionIndex]['options'].asMap().entries.map(
              (entry) {
                int index = entry.key;
                String option = entry.value;

               
                bool isCorrect =
                    index == _questions[_currentQuestionIndex]['answer'];
                bool isSelected = index == _selectedOption;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? (isCorrect
                              ? Colors.green
                              : const Color.fromARGB(255, 97, 179, 226))
                          : const Color.fromARGB(255, 231, 224,
                              225), 
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _answered
                        ? null
                        : () => _selectOption(index), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected)
                          Icon(
                            isCorrect ? Icons.check : Icons.close,
                            color: isCorrect
                                ? Colors.green
                                : const Color.fromARGB(255, 228, 27,
                                    13), 
                          ),
                        SizedBox(width: 10),
                        Text(
                          option,
                          style: TextStyle(
                              color: Colors.black), 
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),

           
            Spacer(),

            
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      0, 148, 85, 85), 
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16),
                  side: BorderSide(
                      color: Colors.black), 
                ),
                onPressed: _selectedOption == null ? null : _nextQuestion,
                child: Text(
                  isLastQuestion ? 'Finish' : 'Next',
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}