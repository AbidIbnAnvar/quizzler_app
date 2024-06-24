import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditQuestions extends StatefulWidget {
  final Map<String, bool> questionAnswers;
  EditQuestions({required this.questionAnswers});
  @override
  State<EditQuestions> createState() => _EditQuestionsState();
  dynamic choice;
}

class _EditQuestionsState extends State<EditQuestions> {
  List<String> questions = [];
  List<Container> questionWidgets = [];
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textInsertingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayQuestions();
    questions = widget.questionAnswers.keys.toList();
  }

  void onPressed(BuildContext context, int index) {
    String question = questions[index];
    textEditingController.text = question;
    bool option = widget.questionAnswers[question] ?? false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editing'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoTextField(
                    padding: EdgeInsets.all(12),
                    autofocus: true,
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    style: TextStyle(
                      color: Colors.white, // Font color
                      fontSize: 16,
                      fontWeight: FontWeight.w400, // Font size
                    ),
                    minLines: 1,
                    maxLines: 10,
                    controller: textEditingController,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Answer: '),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor:
                                (option == true) ? Colors.green : Colors.grey),
                        onPressed: () {
                          setState(() {
                            if (option == false) {
                              option = true;
                            }
                          });
                        },
                        child: Text('True'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor:
                                (option == false) ? Colors.red : Colors.grey),
                        onPressed: () {
                          setState(() {
                            if (option == true) {
                              option = false;
                            }
                          });
                        },
                        child: Text('False'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                widget.questionAnswers.remove(question);
                displayQuestions();
                questions = widget.questionAnswers.keys.toList();
                Navigator.of(context).pop();
              },
              child: Icon(Icons.delete_outline_rounded),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  widget.questionAnswers.remove(question);
                  widget.questionAnswers[textEditingController.text] = option;
                  displayQuestions();
                  questions = widget.questionAnswers.keys.toList();
                });
                Navigator.of(context).pop();
              },
              child: Text('Edit'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void addDialog() {
    bool optionTrue = false;
    bool optionFalse = false;
    bool option = true;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Question'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoTextField(
                    autofocus: true,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    controller: textInsertingController,
                    style: TextStyle(
                      color: Colors.white, // Font color
                      fontSize: 16,
                      fontWeight: FontWeight.w400, // Font size
                    ),
                    minLines: 1,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Answer: '),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: (optionTrue == true)
                                ? Colors.green
                                : Colors.grey),
                        onPressed: () {
                          setState(() {
                            optionTrue = !optionTrue;
                            if (optionTrue == true) {
                              optionFalse = false;
                            }
                          });
                        },
                        child: Text('True'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: (optionFalse == true)
                                ? Colors.red
                                : Colors.grey),
                        onPressed: () {
                          setState(() {
                            optionFalse = !optionFalse;
                            if (optionFalse == true) {
                              optionTrue = false;
                            }
                          });
                        },
                        child: Text('False'),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  if (optionFalse) {
                    option = false;
                  } else if (optionTrue) {
                    option = true;
                  }
                  if (optionFalse || optionTrue) {
                    widget.questionAnswers[textInsertingController.text] =
                        option;
                    displayQuestions();
                    questions = widget.questionAnswers.keys.toList();
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<Container> displayQuestions() {
    setState(() {
      questionWidgets.clear();
      int n = questions.length;
      for (int i = 0; i < n; i++) {
        questionWidgets.add(Container(
          child: GestureDetector(
            onTap: () {
              onPressed(context, i);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  questions[i],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ));
      }
    });
    return questionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Edit Questions',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              addDialog();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 50, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: displayQuestions(),
            ),
          ),
        ),
      ),
    );
  }
}
