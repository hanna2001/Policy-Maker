import 'package:flutter/material.dart';

class ExpirePage extends StatefulWidget {
  ExpirePage({
    Key key,
  }) : super(key: key);
  @override
  _ExpirePageState createState() => _ExpirePageState();
}

class _ExpirePageState extends State<ExpirePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Image.asset('assets/expiryPage.png'),
      ),
    );
  }
}
