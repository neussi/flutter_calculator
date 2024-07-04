import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      home: ScientificCalculatorPage(),
    );
  }
}

class ScientificCalculatorPage extends StatefulWidget {
  @override
  _ScientificCalculatorPageState createState() =>
      _ScientificCalculatorPageState();
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

  void addSpecial(String text) {
    setState(() {
      if (text == "(" ||
          text == ")" ||
          text == "%" ||
          text == "DEL" ||
          text == "π" ||
          text == "Shift") {
        if (text == "(" || text == ")" || text == "%" || text == "π") {
          expression += text;
        } else if (text == "DEL") {
          expression = expression.substring(0, expression.length - 1);
        } else if (text == "Shift") {
          // Implement Shift functionality if needed
        }
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (buttonText == "(" ||
              buttonText == ")" ||
              buttonText == "%" ||
              buttonText == "DEL" ||
              buttonText == "π" ||
              buttonText == "Shift") {
            addSpecial(buttonText);
          } else {
            numClick(buttonText);
          }
        },
        child: Text(buttonText),
      ),
    );
  }

  Widget buildAdvancedButton(String buttonText, Function callback) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
          primary: Colors.red,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => callback(buttonText),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scientific Calculator'),
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
                color: Colors.white,
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
                  buildButton("("),
                  buildButton(")"),
                  buildButton("%"),
                  buildAdvancedButton("/", numClick),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildAdvancedButton("*", numClick),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildAdvancedButton("-", numClick),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildAdvancedButton("+", numClick),
                ],
              ),
              Row(
                children: <Widget>[
                  buildAdvancedButton("DEL", addSpecial),
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
