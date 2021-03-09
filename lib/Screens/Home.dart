import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' as Stella;
import 'package:wallet/Database/Accountdb.dart';
import 'package:wallet/Widgets/MyAppBar.dart';
import 'package:wallet/Widgets/MyDrawer.dart';
import 'package:wallet/Stella/Setup.dart';

class Home extends StatefulWidget {
  dynamic accInfo;

  @override
  _HomeState createState() => _HomeState();
  Home({this.accInfo});
}

class _HomeState extends State<Home> {
  dynamic accData;
  dynamic accInfo;
  bool activateAcc = false;
  bool loading = true;
  bool noAcc = false;

  Future<void> getAccount(String accoundId) async {
    // Stella.KeyPair keyPair = Stella.KeyPair.fromAccountId(accoundId);
    try {
      await sdk.accounts.account(accoundId).then((account) {
        print(account);
        setState(() {
          accData = account.balances;
          activateAcc = false;
          loading = false;
        });
      });
    } catch (e) {
      setState(() {
        activateAcc = true;
        loading = false;
      });
    }
  }

  Future<void> getInitialAccount() async {
    try {
      dynamic initialAcc = await Accountdb.instance.read();
      if (initialAcc.length != 0) {
        setState(() {
          accInfo = initialAcc[0];
        });
        getAccount(accInfo["publicKey"]);
      } else {
        setState(() {
          noAcc = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    accInfo = widget.accInfo;
    print(accInfo);
    if (accInfo?.isNotEmpty ?? false) {
      getAccount(accInfo["publicKey"]);
    } else {
      getInitialAccount();
    }
    // getAccount("GB6YX2Y6TOXRPACQFHEOVDLHTJP6FQ7Q4OXU7IDWTOTBSTRP5S2ZES2R");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: MyAppBar(),
      endDrawer: MyDrawer(
        accInfo: accInfo,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: !activateAcc && !loading
            ? FlatButton(
                textColor: Colors.white,
                height: 60.0,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/token", arguments: {"accInfo": accInfo});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TOKEN',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              )
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: loading
            ? noAcc
                ? Center(
                    child: Text("No Accounts"),
                  )
                : Center(child: LoadingRotating.square())
            : RefreshIndicator(
                backgroundColor: Colors.white,
                color: Colors.black,
                onRefresh: () => getAccount(accInfo["publicKey"]),
                child: activateAcc
                    ? ListView(
                        children: [
                          Center(
                            child: Text("Please Activate Account"),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemBuilder: (context, int i) => Card(
                          // color: Color(0xFF333333),
                          color: Colors.black,
                          child: Container(
                            height: 140,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        accData[i].balance,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        accData[i].assetType == "native"
                                            ? "XLM"
                                            : accData[i].assetCode,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  "/send",
                                                  arguments: {
                                                    "accInfo": accInfo,
                                                    "type":
                                                        accData[i].assetType,
                                                    "code":
                                                        accData[i].assetCode,
                                                    "operation": "send"
                                                  });
                                            },
                                            child: Text(
                                              "Send",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              Navigator.of(context).pushNamed(
                                                  "/receive",
                                                  arguments: {
                                                    "accInfo": accInfo
                                                  });
                                            },
                                            child: Text(
                                              "Receive",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                        itemCount: accData.length,
                      ),
              ),
      ),
    );
  }
}
