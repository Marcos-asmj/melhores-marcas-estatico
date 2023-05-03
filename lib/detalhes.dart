import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Detalhes extends StatefulWidget {
  final int feedId;
  Detalhes({
    Key? key,
    required this.feedId,
  });

  @override
  State<StatefulWidget> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  var data;
  List<dynamic> feedList = [];
  List<dynamic> results = [];

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/feeds.json');
    data = await json.decode(response);

    setState(() {
      loadList();
    });
  }

  void loadList() {
    for (var i = 0; i < data['feeds'].length; i++) {
      feedList.add(data['feeds'][i]);
    }

    setState(() {
      findFeed();
    });
  }

  void findFeed() {
    List<dynamic> listaFiltrada = [];
    listaFiltrada = feedList
        .where((produto) =>
            produto["_id"].toString().contains(widget.feedId.toString()))
        .toList();

    setState(() {
      results = listaFiltrada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Detalhes',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: 2,
                pageSnapping: true,
                itemBuilder: (context, pagePosition) {
                  return Container(
                      child: Image.asset('assets/imgs/produto.jpeg'));
                }),
          ),
          results.isNotEmpty
              ? Text(results[0]["company"]["name"])
              : SizedBox.shrink(),
          results.isNotEmpty
              ? Text(results[0]["product"]["name"])
              : SizedBox.shrink(),
          results.isNotEmpty
              ? Text(results[0]["product"]["description"])
              : SizedBox.shrink(),
          results.isNotEmpty
              ? Text(results[0]["product"]["price"].toString())
              : SizedBox.shrink(),
          results.isNotEmpty
              ? Text(results[0]["likes"].toString())
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
