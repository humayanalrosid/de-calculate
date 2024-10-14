
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {

  final textColor;
  final String buttonText;
  final buttonTapped;

  const Buttons(this.buttonTapped, this.textColor, this.buttonText, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: ClipRRect(
        child: Center(
          child: Text(buttonText, 
          style: TextStyle(
            color: textColor, 
            fontSize: 40, 
            fontWeight: FontWeight.bold),
          )
        ),
      ),
    );
  }
}
