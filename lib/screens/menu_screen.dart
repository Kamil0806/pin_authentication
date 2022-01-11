import 'package:flutter/material.dart';
import 'package:pin_authentication/screens/pin_create_screen.dart';
import 'package:pin_authentication/widgets/custom_button.dart';
import 'package:pin_authentication/globals.dart' as globals;

import 'auth_pin_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: globals.bgColor
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CustomButton(
              buttonText: 'Create PIN',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinCreateScreen()),
                );
              }
            ),



            CustomButton(
              buttonText: 'PIN auth',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthPinScreen()),
                  );
                }
            ),
          ]
        )
      ),
    );
  }
}


