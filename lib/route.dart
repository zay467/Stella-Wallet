import 'package:flutter/material.dart';
import 'package:wallet/Screens/AddAccount.dart';
import 'package:wallet/Screens/CreateAccount.dart';
import 'package:wallet/Screens/Home.dart';
import 'package:wallet/Screens/Receive.dart';
import 'package:wallet/Screens/Send.dart';
import 'package:wallet/Screens/Token.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    print(args);
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => Home());
      case "/switchAcc":
        return MaterialPageRoute(
            builder: (context) => Home(accInfo: args["data"]));
      case "/send":
        return MaterialPageRoute(
            builder: (context) => Send(
                accInfo: args["accInfo"],
                type: args["type"],
                operation: args["operation"],
                code: args["code"]));
      case "/receive":
        return MaterialPageRoute(
            builder: (context) => Receive(
                  accInfo: args["accInfo"],
                ));
      case "/token":
        return MaterialPageRoute(
            builder: (context) => Token(
                  accInfo: args["accInfo"],
                ));
      case "/createAccount":
        return MaterialPageRoute(
            builder: (context) => CreateAccount(
                  accInfo: args["accInfo"],
                ));
      case "/addAccount":
        return MaterialPageRoute(
            builder: (context) => AddAccount(
                  accInfo: args["accInfo"],
                ));
      case "/detailAccount":
        return MaterialPageRoute(
            builder: (context) => AddAccount(
                  data: args["data"],
                  accInfo: args["accInfo"],
                ));
    }
  }
}
