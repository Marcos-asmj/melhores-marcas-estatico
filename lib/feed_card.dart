import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({super.key});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  List<dynamic> feedList = [];
  int tamanhoPagina = 6;
  var data;
  ScrollController _scrollController = ScrollController();

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/feeds.json');
    data = await json.decode(response);

    setState(() {
      loadList();
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadList();
      }
    });

    readJson();
  }

  void loadList() {
    if (tamanhoPagina < 14) {
      for (var i = tamanhoPagina; i < tamanhoPagina + 6; i++) {
        feedList.add(data['feeds'][i - 6]);
        print(feedList.length);
      }
      if (tamanhoPagina <= 12) {
        tamanhoPagina += 6;
        if (tamanhoPagina > 14) {
          tamanhoPagina = 14;
        }
      }
    } else {
      if (tamanhoPagina == 14) {
        for (var i = tamanhoPagina; i < tamanhoPagina + 2; i++) {
          feedList.add(data['feeds'][i - 2]);
        }
        tamanhoPagina += 1;
      }
    }

    setState(() {});
    print(tamanhoPagina);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.8 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: feedList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.asset('assets/imgs/produto.jpeg'),
                ListTile(
                  leading: CircleAvatar(
                      child: Image.asset('assets/imgs/avatar.jpeg')),
                  title: Text(feedList[index]["_id"].toString()),
                ),
                Text(feedList[index]["company"]["name"]),
                Text(feedList[index]["product"]["name"]),
                Text(feedList[index]["product"]["description"]),
                Text(feedList[index]["product"]["price"].toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
