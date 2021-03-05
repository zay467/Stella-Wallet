import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/Components/MyAppBar.dart';
import 'package:wallet/Components/MyDrawer.dart';

class Receive extends StatefulWidget {
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Recipient ID",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text("GB6YX2Y6TOXRPACQFHEOVDLHTJP6FQ7Q4OXU7IDWTOTBSTRP5S2ZES2R"),
              Divider(),
              RaisedButton(
                color: Colors.black,
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text:
                          "GB6YX2Y6TOXRPACQFHEOVDLHTJP6FQ7Q4OXU7IDWTOTBSTRP5S2ZES2R"));
                },
                child: Text(
                  "Copy to Clipboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
