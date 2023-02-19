import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart ';
class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equstionFontsize = 38;
  double resultFontsize = 48;



  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=='C'){
        equation='0';
        result='0';
      }else if(buttonText=='⌫'){
        equation=equation.substring(0,equation.length -1);
        if(equation==''){
          equation='0';
        }
      }
      else if(buttonText=='='){
        equstionFontsize =38;
        resultFontsize=48;
        expression=equation;
        expression=expression.replaceAll('×', '*');
        expression=expression.replaceAll('÷', '/');

        try{
          Parser p=Parser();
          Expression exp =p.parse(expression);
          ContextModel cm = ContextModel();
          result= '${exp.evaluate(EvaluationType.REAL, cm)}';

        }catch(e){
          result='Error';
        }
      }else{
        if(equation=='0'){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }
      }
    });

  }
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
        height: MediaQuery.of(context).size.height * .1 * buttonHeight,
        color: buttonColor,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(16.0),
              shape:RoundedRectangleBorder(

                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                    style: BorderStyle.solid,
                  )
              )),

          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        )

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equstionFontsize, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          SizedBox(height: 50,),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontsize, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          Expanded(
              child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width* .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.indigo),
                        buildButton("÷", 1, Colors.blueAccent),
                        ]
                        ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black12),
                          buildButton("2", 1, Colors.black12),
                          buildButton("3", 1, Colors.black12),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black12),
                          buildButton("5", 1, Colors.black12),
                          buildButton("6", 1, Colors.black12),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black12),
                          buildButton("8", 1, Colors.black12),
                          buildButton("9", 1, Colors.black12),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black12),
                          buildButton("0", 1, Colors.black12),
                          buildButton("00", 1, Colors.black12),
                        ]
                    ),
                      ],
                    ),
                 ),
              Container(
                width: MediaQuery.of(context).size.width* .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blueAccent)
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blueAccent)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blueAccent)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.green)
                        ]
                    ),


                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
