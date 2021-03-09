import 'package:flutter/material.dart';
import 'package:wallet/Database/Accountdb.dart';

class MyDrawer extends StatefulWidget {
  dynamic accInfo;
  @override
  _MyDrawerState createState() => _MyDrawerState();
  MyDrawer({this.accInfo});
}

class _MyDrawerState extends State<MyDrawer> {
  dynamic data = [];
  void getAccounts() async {
    dynamic accounts = await Accountdb.instance.read();
    setState(() {
      data = accounts;
    });
    // print(accounts);
  }

  void removeAccount(int id) async {
    Accountdb.instance.delete(id).then((value) => print(value));
  }

  void insert() async {
    Accountdb.instance.insert({
      Accountdb.publicKey: "Fuck",
      Accountdb.privateKey: "You",
      Accountdb.accName: "Mal2",
    }).then((value) => print(value));
  }

  @override
  void initState() {
    getAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 300,
            child: ListView.builder(
              itemBuilder: (context, int i) => Card(
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              "/switchAcc",
                              arguments: {"data": data[i]});
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            data[i][Accountdb.accName],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (e) {
                        switch (e) {
                          case "Detail":
                            Navigator.of(context).pushNamed("/detailAccount",
                                arguments: {
                                  "data": data[i],
                                  "accInfo": widget.accInfo
                                });

                            break;
                          case "Remove":
                            removeAccount(data[i][Accountdb.idNum]);
                            getAccounts();
                            break;
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "Detail",
                          child: Text("Detail"),
                        ),
                        PopupMenuItem(
                          value: "Remove",
                          child: Text("Remove"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              itemCount: data.length,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          FlatButton(
            // textColor: Colors.white,

            onPressed: () {
              Navigator.of(context).pushNamed("/createAccount",
                  arguments: {"accInfo": widget.accInfo});
            },
            // color: Colors.black,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FlatButton(
            // textColor: Colors.white,

            onPressed: () {
              Navigator.of(context).pushNamed("/addAccount",
                  arguments: {"accInfo": widget.accInfo});
            },
            // color: Colors.black,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Add Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FlatButton(
            // textColor: Colors.white,

            onPressed: () {
              Navigator.of(context).pushNamed("/send", arguments: {
                "accInfo": widget.accInfo,
                "type": "native",
                "operation": "activate"
              });
            },
            // color: Colors.black,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Activate Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // FlatButton(
          //   // textColor: Colors.white,
          //
          //   onPressed: () {},
          //   // color: Colors.black,
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Text(
          //       "Fund this Account",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
