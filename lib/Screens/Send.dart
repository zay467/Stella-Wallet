import 'package:flutter/material.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:wallet/Database/Accountdb.dart';
import 'package:wallet/Stella/Setup.dart';
import 'package:wallet/Widgets/MyAppBar.dart';
import 'package:wallet/Widgets/MyDrawer.dart';

class Send extends StatefulWidget {
  dynamic accInfo;
  dynamic type;
  dynamic operation;
  dynamic code;
  @override
  _SendState createState() => _SendState();
  Send({this.accInfo, this.type, this.operation, this.code});
}

class _SendState extends State<Send> {
  final issuerIdCon = TextEditingController();
  final destinationIdCon = TextEditingController();
  final amountCon = TextEditingController();

  Future<void> generateToken(String issuerPrivateKey, String destination,
      String amount, String assetCode) async {
    try {
      KeyPair issuerKeypair = KeyPair.fromSecretSeed(issuerPrivateKey);

      AccountResponse issuer =
          await sdk.accounts.account(issuerKeypair.accountId);

      // Asset asset = AssetTypeCreditAlphaNum4(assetCode, issuerId);
      Asset asset =
          Asset.createNonNativeAsset(assetCode, issuerKeypair.accountId);

      Transaction transaction = new TransactionBuilder(issuer, net)
          .addOperation(
              PaymentOperationBuilder(destination, asset, amount).build())
          .build();

      transaction.sign(issuerKeypair);

      SubmitTransactionResponse response =
          await sdk.submitTransaction(transaction);

      if (response.success) {
        print("Generate Success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendNonNative(String senderPrivateKey, String destination,
      String amount, String issuerId, String assertCode) async {
    try {
      KeyPair senderKeypair = KeyPair.fromSecretSeed(senderPrivateKey);
      AccountResponse sender =
          await sdk.accounts.account(senderKeypair.accountId);
      // Asset asset = AssetTypeCreditAlphaNum4(assertCode, issuerId);
      Asset asset = Asset.createNonNativeAsset(assertCode, issuerId);
      Transaction transaction = new TransactionBuilder(sender, net)
          .addOperation(
              PaymentOperationBuilder(destination, asset, amount).build())
          .build();
      transaction.sign(senderKeypair);
      SubmitTransactionResponse response =
          await sdk.submitTransaction(transaction);
      if (response.success) {
        print("Payment sent");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> activateAccount(
      String senderPrivateKey, String destination, String amount) async {
    try {
      KeyPair senderKeypair = KeyPair.fromSecretSeed(senderPrivateKey);

      AccountResponse sender =
          await sdk.accounts.account(senderKeypair.accountId);

      Transaction transaction = new TransactionBuilder(sender, net)
          .addOperation(
              new CreateAccountOperationBuilder(destination, amount).build())
          .build();

      transaction.sign(senderKeypair);

      SubmitTransactionResponse response =
          await sdk.submitTransaction(transaction);
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendNative(
      String senderPrivateKey, String destination, String amount) async {
    try {
      KeyPair senderKeypair = KeyPair.fromSecretSeed(senderPrivateKey);
      AccountResponse sender =
          await sdk.accounts.account(senderKeypair.accountId);
      // sourceAccount, fee, sequenceNumber, operations, memo, timeBounds, network
      Transaction transaction = new TransactionBuilder(sender, net)
          .addOperation(
              PaymentOperationBuilder(destination, Asset.NATIVE, amount)
                  .build())
          .build();
      transaction.sign(senderKeypair);
      SubmitTransactionResponse response =
          await sdk.submitTransaction(transaction);
      if (response.success) {
        print("Payment sent");
      }
    } catch (e) {
      print(e);
    }
  }

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
              if (widget.type != "native") ...[
                Text(
                  "Issuer ID",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: issuerIdCon,
                  cursorColor: Colors.black,
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
              ],
              Text(
                "Destination ID",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: destinationIdCon,
                cursorColor: Colors.black,
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
                "Amount",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: amountCon,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Amount",
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
                  if (widget.type == "native") {
                    if (widget.operation == "activate") {
                      print("here");
                      activateAccount(widget.accInfo["privateKey"],
                          destinationIdCon.text, amountCon.text);
                    } else if (widget.operation == "generate") {
                      generateToken(widget.accInfo["privateKey"],
                          destinationIdCon.text, amountCon.text, widget.code);
                    } else {
                      sendNative(widget.accInfo["privateKey"],
                          destinationIdCon.text, amountCon.text);
                    }
                  } else {
                    sendNonNative(
                        widget.accInfo["privateKey"],
                        destinationIdCon.text,
                        amountCon.text,
                        issuerIdCon.text,
                        widget.code);
                  }
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed("/switchAcc",
                  //     arguments: {"data": widget.accInfo});
                },
                child: Text(
                  "Send",
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
