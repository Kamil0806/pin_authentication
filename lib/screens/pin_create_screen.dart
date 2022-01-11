import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pin_authentication/globals.dart' as globals;

import '../main.dart';

class PinCreateScreen extends StatefulWidget {
  const PinCreateScreen({Key? key}) : super(key: key);

  @override
  _PinCreateScreenState createState() => _PinCreateScreenState();
}

class _PinCreateScreenState extends State<PinCreateScreen> {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/pin.txt');
  }

  Future<File> writePin() async {
    final file = await _localFile;
    return file.writeAsString(globals.storedPin);
  }




  String enterText = 'Create PIN';
  int pinIndex = 0;
  String pin = '';
  String rePin = '';
  String checkPin = '';
  bool firstStage = true;

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
          pinIndex++;

        }

        pin += value;

      if (firstStage == false){
        if (rePin.length < 4) {
          if (rePin.isEmpty) {
            pin1.text = '◍';
          }
          if (rePin.length == 1) {
            pin2.text = '◍';
          }
          if (rePin.length == 2) {
            pin3.text = '◍';
          }
          if (rePin.length == 3) {
            pin4.text = '◍';
          }
          pinIndex++;
          rePin += value;
        }
      }

      if (pin.length == 4) {
        firstStage = false;
        pin1.text = '';
        pin2.text = '';
        pin3.text = '';
        pin4.text = '';
        checkPin = pin;
        enterText = 'Re-enter your PIN';
        pinIndex = 0;
      }


      if (rePin.length == 4) {
        if (rePin == checkPin) {
          successAlertDialog(context);
          globals.storedPin = checkPin;
          writePin();

        } else {
          failAlertDialog(context);
          pinIndex = 0;
          pin = '';
          rePin = '';
          pin1.text = '';
          pin2.text = '';
          pin3.text = '';
          pin4.text = '';
          firstStage = true;
          enterText = 'Create PIN';
        }
      }
    });
  }

  successAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Your PIN code is successfully created'),
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
            content: Text('PINs differ. Try again'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              iconSize: 18,
            ),
            Spacer(),
            Text('Setup PIN',
                style: TextStyle(fontSize: 15, color: Colors.black)),
            Spacer(),
            Text(
              'Use 6-digit PIN',
              style: TextStyle(color: globals.fontColor, fontSize: 15),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text(enterText,
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
                  if (firstStage == true) {
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
                  }
                  if (firstStage == false){
                    if (rePin.isNotEmpty) {
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
                      rePin = rePin.substring(0, rePin.length - 1);
                    }
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
