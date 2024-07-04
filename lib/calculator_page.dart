import 'package:flutter/material.dart';
import 'scientific_calculator_page.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String output = "0";
  String operation = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        output = "0";
        operation = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        if (output.endsWith(".") || output.isEmpty) return;
        operation += " $buttonText ";
        output += " $buttonText ";
      } else if (buttonText == ".") {
        if (output.contains(".")) {
          return;
        } else {
          operation += buttonText;
          output += buttonText;
        }
      } else if (buttonText == "=") {
        if (output.endsWith(" ") || operation.isEmpty) return;
        output = _evaluateOperation(operation);
        operation = "($operation)";
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
        operation += buttonText;
      }
    });
  }

  String _evaluateOperation(String operation) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(operation);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toStringAsFixed(2);
    } catch (e) {
      return "Error";
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(24.0)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculatrice Simple'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 12,
            ),
            child: Text(
              operation.isEmpty ? "0.00" : operation,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 12,
            ),
            child: Text(
              output,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("AC"),
                  buildButton("="),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScientificCalculatorPage()),
              );
            },
            child: Text('Calculatrice Scientifique'),
          ),
        ],
      ),
    );
  }
}
