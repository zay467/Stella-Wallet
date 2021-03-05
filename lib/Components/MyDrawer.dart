import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Account ${i + 1}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (e) {
                        switch (e) {
                          case "Detail":
                            Navigator.of(context).pushNamed("/addEditAccount");
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
              itemCount: 16,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          FlatButton(
            // textColor: Colors.white,

            onPressed: () {
              Navigator.of(context).pushNamed("/createAccount");
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
              Navigator.of(context).pushNamed("/addEditAccount");
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
              Navigator.of(context).pushNamed("/send");
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
          FlatButton(
            // textColor: Colors.white,

            onPressed: () {},
            // color: Colors.black,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Fund this Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
