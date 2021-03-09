import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wallet/Screens/Home.dart';
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
