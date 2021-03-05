import 'package:flutter/material.dart';
import 'package:wallet/Screen/Home.dart';
import 'package:wallet/route.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
