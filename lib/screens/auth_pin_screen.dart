import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pin_authentication/globals.dart' as globals;
import 'package:numeric_keyboard/numeric_keyboard.dart';


import '../main.dart';

class AuthPinScreen extends StatefulWidget {
  const AuthPinScreen({Key? key}) : super(key: key);

  @override
  _AuthPinScreenState createState() => _AuthPinScreenState();
}

class _AuthPinScreenState extends State<AuthPinScreen> {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/pin.txt');
  }

  Future<String> readPin() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {

      return 'Error';
    }
  }


  late String checkPin;

  @override
  void initState(){
    super.initState();
    readPin().then((String value) {
      setState(() {
        checkPin = value;
      });
    });
  }

  int pinIndex = 0;
  String pin = '';

  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  _onKeyboardTap(String value) {
    setState(() {
      if (pin.length < 4) {
        if (pin.isEmpty) {
          pin1.text = '◍';
        }
        if (pin.length == 1) {
          pin2.text = '◍';

        }
        if (pin.length == 2) {
          pin3.text = '◍';
        }
        if (pin.length == 3) {
          pin4.text = '◍';
        }
      }

      pin += value;
      pinIndex++;

      if (pin.length == 4) {
        if (pin == checkPin) {
          successAlertDialog(context);
        } else {
          pin1.text = '';
          pin2.text = '';
          pin3.text = '';
          pin4.text = '';
          pin = '';
          pinIndex = 0;
          failAlertDialog(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text('Enter PIN',
                style: TextStyle(color: globals.fontColor, fontSize: 24)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                pinIndicator(context, pin1),
                SizedBox(width: 20),
                pinIndicator(context, pin2),
                SizedBox(width: 20),
                pinIndicator(context, pin3),
                SizedBox(width: 20),
                pinIndicator(context, pin4),
              ],
            ),
            Spacer(),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: globals.fontColor,
              rightButtonFn: () {
                setState(() {
                    if (pin.isNotEmpty) {
                      if (pinIndex == 1) {
                        pin1.text = '';
                        pinIndex--;
                      }
                      if (pinIndex == 2) {
                        pin2.text = '';
                        pinIndex--;
                      }
                      if (pinIndex == 3) {
                        pin3.text = '';
                        pinIndex--;
                      }
                      if (pinIndex == 4) {
                        pin4.text = '';
                        pinIndex--;
                      }
                      pin = pin.substring(0, pin.length - 1);
                    }
                });
              },
              rightIcon: Icon(
                Icons.backspace,
                color: globals.fontColor,
              ),
            ),
            SizedBox(height: 80)
          ],
        ),
      ),
    );
  }
}

successAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Authentication success'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PinAuthApp()),
                  );
                },
                child: Text('Ok'))
          ],
        );
      });
}

failAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Authentication failed'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'))
          ],
        );
      });
}

pinIndicator(BuildContext context, TextEditingController txtController) {
  Color fillClr = Colors.white;
  return Container(
      width: 40,
      height: 40,
      child: TextField(
        textAlign: TextAlign.center,
        enabled: false,
        controller: txtController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          fillColor: fillClr,
        ),
        autofocus: true,
        style: TextStyle(color: Colors.blue, fontSize: 10),
      )
  );
}
