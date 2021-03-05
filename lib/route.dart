import 'package:flutter/material.dart';
import 'package:wallet/Screen/AddEditAccount.dart';
import 'package:wallet/Screen/CreateAccount.dart';
import 'package:wallet/Screen/Home.dart';
import 'package:wallet/Screen/Receive.dart';
import 'package:wallet/Screen/Send.dart';
import 'package:wallet/Screen/Token.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => Home());
      case "/send":
        return MaterialPageRoute(builder: (context) => Send());
      case "/receive":
        return MaterialPageRoute(builder: (context) => Receive());
      case "/token":
        return MaterialPageRoute(builder: (context) => Token());
      case "/createAccount":
        return MaterialPageRoute(builder: (context) => CreateAccount());
      case "/addEditAccount":
        return MaterialPageRoute(builder: (context) => AddAccount());
    }
  }
}
