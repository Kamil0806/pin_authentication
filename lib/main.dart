import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/pin_create_screen.dart';
import 'screens/auth_pin_screen.dart';

void main() => runApp(PinAuthApp());

class PinAuthApp extends StatefulWidget {
  const PinAuthApp({Key? key}) : super(key: key);
  @override
  _PinAuthAppState createState() => _PinAuthAppState();
}

class _PinAuthAppState extends State<PinAuthApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => MenuScreen(),
        '/pin-create' : (context) => PinCreateScreen(),
        '/auth-pin' : (context) => AuthPinScreen(),
        }
    );
  }
}


