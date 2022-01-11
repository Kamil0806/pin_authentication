import 'package:flutter/material.dart';
import 'package:pin_authentication/globals.dart' as globals;

class CustomButton extends StatelessWidget {

  final GestureTapCallback onPressed;
  final String buttonText;

  CustomButton({required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              buttonText,
              maxLines: 1,
              style: TextStyle(
                  color: globals.fontColor
              ),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: StadiumBorder(
          side: BorderSide(
              width: 1,
              color: globals.fontColor
          )
      ),
    );
  }
}