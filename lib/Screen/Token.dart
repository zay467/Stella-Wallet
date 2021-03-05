import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/Components/MyAppBar.dart';
import 'package:wallet/Components/MyDrawer.dart';

class Token extends StatefulWidget {
  @override
  _TokenState createState() => _TokenState();
}

class _TokenState extends State<Token> {
  String assertType;
  String assertInfo = "Asset code must be between 1 and 4 characters long.";

  @override
  void initState() {
    assertType = "Alphanumeric 4";
    super.initState();
  }

  void radioOnChange4(String value) {
    setState(() {
      assertType = value;
      assertInfo = "Asset code must be between 1 and 4 characters long.";
    });
  }

  void radioOnChange12(String value) {
    setState(() {
      assertType = value;
      assertInfo = "Asset code must be between 5 and 12 characters long.";
    });
  }

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
                    "Issue",
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
                          "Assert Type",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: Colors.black,
                                value: "Alphanumeric 4",
                                groupValue: assertType,
                                onChanged: radioOnChange4),
                            Text("Alphanumeric 4"),
                            Radio(
                                activeColor: Colors.black,
                                value: "Alphanumeric 12",
                                groupValue: assertType,
                                onChanged: radioOnChange12),
                            Text("Alphanumeric 12"),
                          ],
                        ),
                        Divider(),
                        Text(
                          "Assert Code",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: assertInfo,
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
                          onPressed: () {},
                          child: Text(
                            "Issue",
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
                  Center(
                    child: Text("This feature is only for Issuer."),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
