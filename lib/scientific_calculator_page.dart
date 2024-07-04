import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ScientificCalculatorPage extends StatefulWidget {
  @override
  _ScientificCalculatorPageState createState() => _ScientificCalculatorPageState();
}

class _ScientificCalculatorPageState extends State<ScientificCalculatorPage> {
  String expression = "";
  String result = "0";

  void numClick(String text) {
    setState(() {
      expression += text;
    });
  }

  void allClear(String text) {
    setState(() {
      expression = "";
      result = "0";
    });
  }

  void clear(String text) {
    setState(() {
      expression = "";
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();

    setState(() {
      result = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        onPressed: () => numClick(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildAdvancedButton(String buttonText, Function callback) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        onPressed: () => callback(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculatrice Scientifique'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 12,
            ),
            child: Text(
              expression,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
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
              result,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildAdvancedButton("sin", numClick),
                  buildAdvancedButton("cos", numClick),
                  buildAdvancedButton("tan", numClick),
                  buildAdvancedButton("log", numClick),
                ],
              ),
              Row(
                children: <Widget>[
                  buildAdvancedButton("ln", numClick),
                  buildAdvancedButton("exp", numClick),
                  buildAdvancedButton("^", numClick),
                  buildAdvancedButton("sqrt", numClick),
                ],
              ),
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
                  buildAdvancedButton("AC", allClear),
                  buildAdvancedButton("=", evaluate),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
