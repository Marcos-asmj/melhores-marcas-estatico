import 'package:flutter/material.dart';
import 'feed.dart';
import 'login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Feed(),
      initialRoute: '/',
      routes: {
        '/': (context) => Feed(),
        '/login': (context) => Login(),
      },
    );
  }
}
