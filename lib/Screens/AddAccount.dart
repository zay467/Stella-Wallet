import 'package:flutter/material.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:wallet/Widgets/MyAppBar.dart';
import 'package:wallet/Widgets/MyDrawer.dart';
import 'package:wallet/Database/Accountdb.dart';

class AddAccount extends StatefulWidget {
  dynamic data;
  dynamic accInfo;
  @override
  _AddAccountState createState() => _AddAccountState();
  AddAccount({this.data, this.accInfo});
}

class _AddAccountState extends State<AddAccount> {
  final accNameCon = TextEditingController();
  final publicKeyCon = TextEditingController();
  final privateKeyCon = TextEditingController();
  bool editAccount;

  void addAccount() async {
    try {
      Accountdb.instance.insert({
        Accountdb.publicKey: publicKeyCon.text,
        Accountdb.privateKey: privateKeyCon.text,
        Accountdb.accName: accNameCon.text,
      }).then((value) => print(value));
    } catch (e) {
      print(e);
    }
  }

  void updateAccount() async {
    try {
      Accountdb.instance.update({
        Accountdb.idNum: widget.data["_id"],
        Accountdb.publicKey: publicKeyCon.text,
        Accountdb.privateKey: privateKeyCon.text,
        Accountdb.accName: accNameCon.text
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    editAccount = widget.data?.isNotEmpty ?? false;
    if (editAccount) {
      accNameCon.text = widget.data["accName"];
      publicKeyCon.text = widget.data["publicKey"];
      privateKeyCon.text = widget.data["privateKey"];
    }
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
                cursorColor: Colors.black,
                controller: accNameCon,
                decoration: InputDecoration(
                  hintText: "Account 1",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              Text(
                "Public Key",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                cursorColor: Colors.black,
                controller: publicKeyCon,
                decoration: InputDecoration(
                  hintText: "eg : G.....",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              Text(
                "Private Key",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                cursorColor: Colors.black,
                controller: privateKeyCon,
                decoration: InputDecoration(
                  hintText: "eg : S.....",
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
                  if (editAccount) {
                    updateAccount();
                  } else {
                    addAccount();
                  }
                  Navigator.of(context).pushReplacementNamed("/switchAcc",
                      arguments: {"data": widget.accInfo});
                },
                child: Text(
                  editAccount ? "Edit Account" : "Add Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              if (editAccount) ...[
                RaisedButton(
                  // textColor: Colors.white,
                  color: Colors.black,
                  onPressed: () {
                    FriendBot.fundTestAccount(publicKeyCon.text);
                    Navigator.of(context).pushReplacementNamed("/switchAcc",
                        arguments: {"data": widget.accInfo});
                  },
                  // color: Colors.black,
                  child: Text(
                    "Fund this Account",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
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
