import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:handicraft/splashScreen.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Text(typed),
            Text(App.sharedPreferences.getString("type"))
          ],
        ),
      ),
    );
  }
}
