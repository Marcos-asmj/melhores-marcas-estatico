import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'feed_card.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<dynamic> feedList = [];
  int tamanhoPagina = 6;
  var data;
  List<dynamic> foundFeeds = [];
  ScrollController _scrollController = ScrollController();

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/feeds.json');
    data = await json.decode(response);
    //print(data);

    setState(() {
      loadList();
    });
  }

  @override
  void initState() {
    readJson();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadList();
      }
    });
    foundFeeds = feedList;

    super.initState();
  }

  void loadList() {
    if (tamanhoPagina < 14) {
      for (var i = tamanhoPagina; i < tamanhoPagina + 6; i++) {
        feedList.add(data['feeds'][i - 6]);
        //print(feedList.length);
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
    //print(tamanhoPagina);
    //print(feedList);
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = feedList;
    } else {
      results = feedList
          .where((produto) => produto["product"]["name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundFeeds = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Feeds'),
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 90, right: 50),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.account_circle_outlined),
            color: Colors.black,
          ),
        ],
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.2 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: foundFeeds.length,
        itemBuilder: (context, index) {
          return FeedCard(
              nomeEmpresa: foundFeeds[index]["company"]["name"],
              nomeProduto: foundFeeds[index]["product"]["name"],
              descricaoProduto: foundFeeds[index]["product"]["description"],
              precoProduto: foundFeeds[index]["product"]["price"],
              likes: foundFeeds[index]["likes"]);
        },
      ),
    );
  }
}
