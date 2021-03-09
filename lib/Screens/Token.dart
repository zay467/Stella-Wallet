import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' as Stella;
import 'package:wallet/Stella/Setup.dart';
import 'package:wallet/Widgets/MyAppBar.dart';
import 'package:wallet/Widgets/MyDrawer.dart';
import 'package:http/http.dart' as http;

class Token extends StatefulWidget {
  dynamic accInfo;
  @override
  _TokenState createState() => _TokenState();
  Token({this.accInfo});
}

class _TokenState extends State<Token> {
  final issuerIdCon = TextEditingController();
  final assertCodeCon = TextEditingController();
  final limitCon = TextEditingController();
  dynamic asset = [];
  bool loading = true;

  // String assertType;
  // String assertInfo = "Asset code must be between 1 and 4 characters long.";
  Future<void> checkAsset(String accountId) async {
    try {
      var response = await http.get(
          "https://horizon-testnet.stellar.org/assets?asset_issuer=${accountId}");
      var decodeData = await jsonDecode(response.body);
      setState(() {
        asset = decodeData["_embedded"]["records"];
        loading = false;
        print(asset);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> issue(String trustorPrivateKey, String issuerId,
      String assetCode, String limit) async {
    try {
      Stella.KeyPair trustorKeypair =
          Stella.KeyPair.fromSecretSeed(trustorPrivateKey);

      Stella.AccountResponse trustor =
          await sdk.accounts.account(trustorKeypair.accountId);

      Stella.Asset asset =
          Stella.Asset.createNonNativeAsset(assetCode, issuerId);

      Stella.ChangeTrustOperationBuilder changeTrustOperation =
          Stella.ChangeTrustOperationBuilder(asset, limit);

      Stella.Transaction transaction =
          new Stella.TransactionBuilder(trustor, net)
              .addOperation(changeTrustOperation.build())
              .build();

      transaction.sign(trustorKeypair);

      Stella.SubmitTransactionResponse response =
          await sdk.submitTransaction(transaction);

      if (response.success) {
        print("Success");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // assertType = "Alphanumeric 4";
    checkAsset(widget.accInfo["publicKey"]);
    super.initState();
  }

  // void radioOnChange4(String value) {
  //   setState(() {
  //     assertType = value;
  //     assertInfo = "Asset code must be between 1 and 4 characters long.";
  //   });
  // }
  //
  // void radioOnChange12(String value) {
  //   setState(() {
  //     assertType = value;
  //     assertInfo = "Asset code must be between 5 and 12 characters long.";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: MyDrawer(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Create Trustline",
                  ),
                ),
                Tab(
                  child: Text(
                    "Generate",
                  ),
                )
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Issuer ID",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          cursorColor: Colors.black,
                          controller: issuerIdCon,
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
                        // Divider(),
                        // Text(
                        //   "Assert Type",
                        //   style: TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.bold),
                        // ),
                        // Row(
                        //   children: [
                        //     Radio(
                        //         activeColor: Colors.black,
                        //         value: "Alphanumeric 4",
                        //         groupValue: assertType,
                        //         onChanged: radioOnChange4),
                        //     Text("Alphanumeric 4"),
                        //     Radio(
                        //         activeColor: Colors.black,
                        //         value: "Alphanumeric 12",
                        //         groupValue: assertType,
                        //         onChanged: radioOnChange12),
                        //     Text("Alphanumeric 12"),
                        //   ],
                        // ),
                        Divider(),
                        Text(
                          "Assert Code",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: assertCodeCon,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 12),
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
                          "Limit",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: limitCon,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 12),
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
                            issue(
                                widget.accInfo["privateKey"],
                                issuerIdCon.text,
                                assertCodeCon.text,
                                limitCon.text);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Create Trustline",
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
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  loading
                      ? Center(
                          child: LoadingRotating.square(),
                        )
                      : RefreshIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                          onRefresh: () =>
                              checkAsset(widget.accInfo["publicKey"]),
                          child: asset.length == 0
                              ? ListView(children: [
                                  Center(
                                    child: Text("This feature is for issuer."),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ])
                              : ListView.builder(
                                  itemCount: asset.length,
                                  itemBuilder: (context, int i) => Card(
                                    color: Colors.black,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    "/send",
                                                    arguments: {
                                                      "accInfo": widget.accInfo,
                                                      "type": "native",
                                                      "code": asset[i]
                                                          ["asset_code"],
                                                      "operation": "generate"
                                                    });
                                              },
                                              child: Text(
                                                asset[i]["asset_code"],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
