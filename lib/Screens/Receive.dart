import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/Widgets/MyAppBar.dart';
import 'package:wallet/Widgets/MyDrawer.dart';

class Receive extends StatefulWidget {
  dynamic accInfo;
  @override
  _ReceiveState createState() => _ReceiveState();
  Receive({this.accInfo});
}

class _ReceiveState extends State<Receive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: MyDrawer(accInfo: widget.accInfo),
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
              Text(widget.accInfo["publicKey"]),
              Divider(),
              RaisedButton(
                color: Colors.black,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: widget.accInfo["publicKey"]));
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
