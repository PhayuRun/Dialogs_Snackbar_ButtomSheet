import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final snackBar = SnackBar(
    content: Text('Successfully Saved'),
    backgroundColor: Colors.deepOrange,
    duration: Duration(seconds: 1),
    action: SnackBarAction(
      onPressed: () {},
      label: 'Undo',
    ),
  );
  String delete = 'No Choice Made';
  String location = 'None Selected yet';
  String buttomSheetVal = 'Nothing Selected';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                'Save',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.red,
                          width: 5,
                        ),
                      ),
                      title: Text('Delete entry 12345 ?'),
                      content: Text(
                        'Are you sure that you want to delete the Entry',
                      ),
                      actions: [
                        TextButton(
                          child: Text('NO'),
                          onPressed: () {
                            setState(() {
                              delete = 'You Deleted NO';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('YES'),
                          onPressed: () {
                            setState(() {
                              delete = 'You Deleted YES';
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Text('Delete'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('$delete'),
            ElevatedButton(
              onPressed: () async {
                final String loc = await showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Choose Your Location'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'South America');
                          },
                          child: Text('South America'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'America');
                          },
                          child: Text('America'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'South Africa');
                          },
                          child: Text('South Africa'),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  location = loc;
                });
              },
              child: Text('Choose Location'),
            ),
            Text('$location'),
            ElevatedButton(
              onPressed: () {
                scaffoldKey.currentState?.showBottomSheet(
                  (context) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Are you sure you want to delete ?',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        buttomSheetVal = 'YES';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        buttomSheetVal = 'NO';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Buttom Sheet'),
            ),
            Text('$buttomSheetVal'),
          ],
        ),
      ),
    );
  }
}
