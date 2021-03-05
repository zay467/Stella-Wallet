import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/Components/MyAppBar.dart';
import 'package:wallet/Components/MyDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "Wallet";
  int count = 3;
  Future<void> test() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: MyDrawer(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: FlatButton(
          textColor: Colors.white,
          height: 60.0,
          onPressed: () {
            Navigator.of(context).pushNamed("/token");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOKEN',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.black,
          onRefresh: test,
          child: ListView.builder(
            itemBuilder: (context, int i) => Card(
              // color: Color(0xFF333333),
              color: Colors.black,
              child: Container(
                height: 120,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: FittedBox(
                                alignment: Alignment.topRight,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "1000.00",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Expanded(
                              child: Text(
                                "XLM",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/send");
                                },
                                child: Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/receive");
                                },
                                child: Text(
                                  "Receive",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            itemCount: count,
          ),
        ),
      ),
    );
  }
}
