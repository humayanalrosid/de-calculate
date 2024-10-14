import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/buttons.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var userInput = '';
  var userOutput = '';
  var lastAnswer = '';

  final List<String> buttons = [
    'C','DEL','%','/',
    '9','8','7','*',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','ANS','=',
  ];

  bool isOperator(String x) {
    if(x == '%' || x == '/' || x == '*' || x == '+' || x == '-' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  bool isValidInput(String input) {
    if (input.isEmpty || isOperator(input[0])) {
      return false;
    }
    
    for (int i = 0; i < input.length - 1; i++) {
      if (isOperator(input[i]) && isOperator(input[i + 1])) {
        return false;
      }
    }
    return true;
  }


  double equalTo() {
    String finalInput = userInput.replaceAll(' ', '');
    Parser p = Parser();
    
    try {
      Expression exp = p.parse(finalInput); 
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm); 
      return eval;  
    } catch (e) {
      if (e is RangeError) {
        return 0;  
      } else {
        return 0; 
      }
    }
  }

  String formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 50,),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(userInput,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(userOutput,
                  style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                )
              ),
            ],
          ),
        ),

        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xff012a4a),
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              itemBuilder: (BuildContext, int index) {
                
                // clear button
                if (index == 0) {
                  return Buttons(
                      (){
                        setState(() {
                          userInput = '';
                          userOutput = '';
                        });
                      },
                      Colors.white,
                      buttons[index]
                    );
                
                // delete button
                } else if (index == 1) {
                    return Buttons(
                        (){
                          setState(() {
                            userInput = (userInput.isEmpty) ? '' : userInput.substring(0, userInput.length-1);
                          });
                        },
                        Colors.white,
                        buttons[index]
                    );
            
                // equal button
                }  else if (index == buttons.length - 1) {
                    return Buttons(
                        (){
                          setState(() {
                            if (userInput.isNotEmpty) {
                              double res = equalTo();
                              userOutput = res == 0 ? "Error" : formatResult(res);  
                              lastAnswer = userOutput.toString();
                            } 
                          });
                        },
                        Colors.white,
                        buttons[index]
                    );
                
                // ans button
                } else if (index == buttons.length - 2) {
                  return Buttons(
                      () {
                        setState(() {
                          if (lastAnswer.isNotEmpty) {
                            userInput += lastAnswer; 
                          }
                        });
                      },
                      Colors.white, 
                      buttons[index]
                    );
            
                } else {
                    return Buttons(
                        (){
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        Colors.white,
                        buttons[index]
                  );
                }
              }
            ),
          ),
          
        ),
      ],
    );
  }
}
