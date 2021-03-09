import 'package:flutter/material.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:wallet/Widgets/MyAppBar.dart';
import 'package:wallet/Widgets/MyDrawer.dart';
import 'package:wallet/Database/Accountdb.dart';

class CreateAccount extends StatefulWidget {
  dynamic accInfo;
  @override
  _CreateAccountState createState() => _CreateAccountState();
  CreateAccount({this.accInfo});
}

class _CreateAccountState extends State<CreateAccount> {
  final accNameCon = TextEditingController();

  void createAccount() async {
    try {
      KeyPair keyPair = KeyPair.random();
      Accountdb.instance.insert({
        Accountdb.publicKey: keyPair.accountId,
        Accountdb.privateKey: keyPair.secretSeed,
        Accountdb.accName: accNameCon.text,
      }).then((value) => print(value));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: MyDrawer(
        accInfo: widget.accInfo,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Account Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: accNameCon,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            Divider(),
            RaisedButton(
              color: Colors.black,
              onPressed: () {
                createAccount();
                Navigator.of(context).pushNamed("/switchAcc",
                    arguments: {"data": widget.accInfo});
                // Navigator.of(context).pop();
                // while (Navigator.canPop(context)) {
                //   Navigator.pop(context);
                // }
                // Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
              },
              child: Text(
                "Create Account",
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
        )),
      ),
    );
  }
}
