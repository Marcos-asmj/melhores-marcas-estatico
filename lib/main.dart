import 'package:flutter/material.dart';
import 'feed_card.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedCard(),
    );
  }
}
