import 'package:flutter/material.dart';

main() => runApp(Calc());

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  Color btncolor, bcolor;
  String result = "result";
  String equ = "";
  double resultfont = 70.0;
  double equfont = 40.0;
  String opration = "";
  double number1 = 0;
  double number2 = 0;
  String display = "";

  keypress(op) {
    setState(() {
      if (op == "+" || op == "/" || op == '*' || op == '-') {
        if (display == "") {
          return;
        }

        if (number1 != 0) {
          number2 = double.parse(display);

          if (opration == "+") {
            result = (number1 + number2).toStringAsFixed(2);
          } else if (opration == "*") {
            result = (number1 * number2).toStringAsFixed(2);
          } else if (opration == "-") {
            result = (number1 - number2).toStringAsFixed(2);
          } else if (opration == "/") {
            if (number2 == 0) {
              result = "Can't Divide by 0";
              resultfont = 30.0;
              equfont = 70.0;
            } else {
              result = (number1 / number2).toStringAsFixed(2);
            }
          }
          number1 = double.parse(result);
          number2 = 0;
          equ = number1.toString();
          display = "";
          opration = op;
          equ = equ + op;
        } else {
          resultfont = 40.0;
          equfont = 70.0;
          result = "";
          number1 = double.parse(display);
          equ = number1.toString();
          display = "";
          opration = op;
          equ = equ + op;
        }
      } else if (op == '%') {
        resultfont = 70.0;
        equfont = 40.0;
        number1 = double.parse(display);
        result = (number1 / 100).toString();
        equ = equ + op;
        display = result;
        number1 = 0;
      } else if (op == "=") {
        if (display == "") {
          return;
        }

        resultfont = 70.0;
        equfont = 40.0;
        number2 = double.parse(display);

        if (opration == "+") {
          result = (number1 + number2).toStringAsFixed(2);
        } else if (opration == "*") {
          result = (number1 * number2).toStringAsFixed(2);
        } else if (opration == "-") {
          result = (number1 - number2).toStringAsFixed(2);
        } else if (opration == "/") {
          if (number2 == 0) {
            result = "Can't Divide by 0";
            resultfont = 30.0;
            equfont = 70.0;
          } else {
            result = (number1 / number2).toStringAsFixed(2);
          }
        }
        display = result;
        number1 = 0;
      } else if (op == "AC") {
        equ = "";
        result = "";
        resultfont = 70.0;
        equfont = 40.0;
        display = "";
        number1 = 0;
        number2 = 0;
      } else if (op == "Back") {
        result = "";
        resultfont = 40.0;
        equfont = 70.0;
        if (equ == "") {
          return;
        } else {
          equ = equ.substring(0, equ.length - 1);
          display = display.substring(0, display.length - 1);
        }
      } else if (op == '.') {
        if (display.contains(".")) {
          return;
        } else {
          equ = equ + op;
          display = display + op;
        }
      } else {
        resultfont = 40.0;
        equfont = 70.0;
        if (equ == "0" || equ == "00") {
          equ = op;
          display = op;
        } else {
          if (result.isNotEmpty && number2 != 0) {
            display = op;
            equ = op;
            result = "";
          } else {
            display = display + op;
            equ = equ + op;
          }
        }
      }
    });
  }

  Widget mybutton(String op, col) {
    if (col == 1) {
      btncolor = Colors.orangeAccent;
      if (op == "=") {
        bcolor = Colors.orangeAccent;
        btncolor = Colors.white;
      }
    } else {
      btncolor = Colors.black;
      bcolor=Color(0xFFFFFFFF);
    }
    return Expanded(
      child: MaterialButton(
        color: bcolor,
        height: 105,
        onPressed: () {
          keypress(op);
        },
        child: Text(
          op,
          style: TextStyle(fontSize: 30, color: btncolor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calc",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              "Calculator",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment(1, 1),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    equ,
                    //softWrap: false,
                    style: TextStyle(
                        fontSize: equfont, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment(1, -1),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    /* result = result.contains(".") ? result.replaceAll("0*$","").replaceAll("\\.$","") : */ result,
                    style: TextStyle(
                        fontSize: resultfont, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      mybutton("AC", 0),
                      mybutton("Back", 0),
                      mybutton("%", 0),
                      mybutton("/", 1),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      mybutton("7", 0),
                      mybutton("8", 0),
                      mybutton("9", 0),
                      mybutton("*", 1),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      mybutton("4", 0),
                      mybutton("5", 0),
                      mybutton("6", 0),
                      mybutton("-", 1),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      mybutton("1", 0),
                      mybutton("2", 0),
                      mybutton("3", 0),
                      mybutton("+", 1),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      //Image.network("https://logodesignfx.com/wp-content/uploads/2019/04/evolution-of-apple-logo-.png"),
                      mybutton(".", 0),
                      mybutton("0", 0),
                      mybutton("00", 0),
                      mybutton("=", 1),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
