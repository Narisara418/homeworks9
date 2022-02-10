// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GUESS THE NUMBER',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  late Game _game;
  static const buttonsize = 70.0;

  Login({Key? key}) : super(key: key) {
    _game = Game(maxRandom: 100);
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _input = '';
  var _num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          // เทียบเท่ากับ <div> ของ HTML
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrange.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.6),
                  offset: const Offset(10.0, 10.0),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                ),
              ]),

          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock, // รูปไอคอน
                          size: 100.0, // ขนาดไอคอน
                          color: Colors.pink, // สีไอคอน
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text('Enter PIN to login'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 6; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          margin: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: (i < _num)?
                            Colors.deepOrange
                            : Colors.deepOrange.shade200,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i <= 3; i++) _buildButton4(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 4; i <= 6; i++) _buildButton4(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 7; i <= 9; i++) _buildButton4(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton4(-2),
                  _buildButton4(0),
                  _buildButton4(-1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton4(int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(Login.buttonsize / 2),
        child: InkWell(
          onTap: () {
            if (num == -2) {
              setState(() {
                _input = '';
                _num = 0;
              });
            } else if (num == -1) {
              print('Backspace');
              setState(() {
                var length = _input.length;
                _input = _input.substring(0, length - 1);
                _num = _num - 1;
              });
            } else {
              print('$num');
              print('$_num');
              print('$_input');
              setState(() {
                _num++;
                _input = '$_input$num';
                if(_num == 6){
                  if (_input == '123456') {
                    setState(() {
                      _input = '';
                      _num = 0;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondRoute()),
                    );
                  } else {
                    setState(() {
                      _input = '';
                      _num = 0;
                    });
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Incorrect PIN'),
                            content: Text('Please try again'),
                            actions: [
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'))
                            ],
                          );
                        });
                  }
                }
              });

            }
          },
          borderRadius: BorderRadius.circular(Login.buttonsize / 2),
          child: Container(
            decoration: (num == -1 || num == -2)
            ? null
            : BoxDecoration(
              border: Border.all(color: Colors.deepOrange, width: 4.0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            width: Login.buttonsize,
            height: Login.buttonsize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (num == -1)
                  Icon(
                    Icons.backspace, // รูปไอคอน
                    size: 30.0, // ขนาดไอคอน
                    color: Colors.pink,
                  )
                else if (num == -2)
                  Icon(
                    Icons.clear, // รูปไอคอน
                    size: 30.0, // ขนาดไอคอน
                    color: Colors.pink,
                  )
                else
                  Text('$num'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: SizedBox.expand(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/m1.png', width: 200),
            ],
          ),
        ),
      ),
    );
  }
}
