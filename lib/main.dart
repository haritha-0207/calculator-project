import 'package:flutter/material.dart';
import 'camera.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String click = "";
  String result = "";
  late int num1, num2;
  String? operator;

  void onButtonClick(String value) {
    if (value == "C") {

      setState(() {
        click = "";
        result = "";
        num1 = 0;
        num2 = 0;
        operator = null;
      });
    } else if (value == "⌫") {
      // Handle backspace
      if (click.isNotEmpty) {
        setState(() {
          click = click.substring(0, click.length - 1);
        });
      }
    } else if (value == "+" || value == "-" || value == "*" || value == "/") {

      if (click.isNotEmpty) {
        num1 = int.parse(click);
        operator = value;
        setState(() {
          click = "";
        });
      }
    } else if (value == "=") {
      // Equal button clicked
      if (click.isNotEmpty && operator != null) {
        num2 = int.parse(click);
        setState(() {
          if (operator == "+") {
            result = (num1 + num2).toString();
          } else if (operator == "-") {
            result = (num1 - num2).toString();
          } else if (operator == "*") {
            result = (num1 * num2).toString();
          } else if (operator == "/") {
            result = (num1 / num2).toString();
          }
          click = result;
        });
      }
    } else {

      setState(() {
        click += value;
      });
    }
  }

  Widget buildButton(String text,
      {Color bgColor = Colors.white, Color textColor = Colors.black}) {
    return InkWell(
      onTap: () {
        onButtonClick(text);
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Calculator', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [

          Expanded(
            flex:0,
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical:2, horizontal:2),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    click,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 32, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          // Button grid
          Expanded(
            flex:18,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing:20,
                children: [
                  buildButton("C", bgColor: Colors.grey[200]!),
                  buildButton("%", bgColor: Colors.grey[200]!),
                  buildButton("⌫", bgColor: Colors.grey[200]!),
                  buildButton("/", bgColor: Colors.orange, textColor: Colors.white),
                  buildButton("7", bgColor: Colors.grey[200]!),
                  buildButton("8", bgColor: Colors.grey[200]!),
                  buildButton("9", bgColor: Colors.grey[200]!),
                  buildButton("*", bgColor: Colors.orange, textColor: Colors.white),
                  buildButton("4", bgColor: Colors.grey[200]!),
                  buildButton("5", bgColor: Colors.grey[200]!),
                  buildButton("6", bgColor: Colors.grey[200]!),
                  buildButton("-", bgColor: Colors.orange, textColor: Colors.white),
                  buildButton("1", bgColor: Colors.grey[200]!),
                  buildButton("2", bgColor: Colors.grey[200]!),
                  buildButton("3", bgColor: Colors.grey[200]!),
                  buildButton("+", bgColor: Colors.orange, textColor: Colors.white),
                  buildButton(".", bgColor: Colors.grey[200]!),
                  buildButton("0", bgColor: Colors.grey[200]!),
                  buildButton("00", bgColor: Colors.grey[200]!),
                  buildButton("=", bgColor: Colors.purple, textColor: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalculatorScreen() ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalculatorScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileImagePicker()),
            );
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple),
            label: 'Provider',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Colors.purple),
            label: 'GetX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file, color: Colors.purple),
            label: 'Upload',
          ),
        ],
        selectedItemColor: Colors.purple,
      ),
    );
  }
}

// New screen class
class AnotherScreen extends StatelessWidget {
  final String screenName;

  AnotherScreen({required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenName),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Welcome to $screenName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
