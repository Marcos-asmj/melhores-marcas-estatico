import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Detalhes extends StatefulWidget {
  final int feedId;
  const Detalhes({
    Key? key,
    required this.feedId,
  });

  @override
  State<StatefulWidget> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  var data;
  var data2;
  List<dynamic> feedList = [];
  List<dynamic> results = [];
  List<dynamic> commentList = [];
  List<dynamic> comments = [];
  late int selectedPage;
  late final PageController _pageController;
  var CommentController = TextEditingController();
  String newComment = '';

  @override
  void initState() {
    initializeDateFormatting('pt_BR');
    readJson();
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/feeds.json');
    data = await json.decode(response);

    final String response2 =
        await rootBundle.loadString('assets/json/comentarios.json');
    data2 = await json.decode(response2);

    setState(() {
      loadList();
    });
  }

  void loadList() {
    for (var i = 0; i < data['feeds'].length; i++) {
      feedList.add(data['feeds'][i]);
    }

    for (var i = 0; i < data2['comentarios'].length; i++) {
      commentList.add(data2['comentarios'][i]);
    }

    setState(() {
      findFeed();
    });
  }

  void findFeed() {
    List<dynamic> listaFiltrada = [];
    List<dynamic> comentariosFiltrados = [];

    listaFiltrada = feedList
        .where((produto) =>
            produto["_id"].toString().contains(widget.feedId.toString()))
        .toList();

    comentariosFiltrados = commentList
        .where((comentario) =>
            comentario["feed"].toString().contains(widget.feedId.toString()))
        .toList();

    setState(() {
      results = listaFiltrada;
      comments = comentariosFiltrados;
    });
  }

  void addComment(String comment) {
    var newCommentData = {
      "content": comment,
      "user": {
        "name": "Nome do Usuário",
      },
      "datetime": DateTime.now().toString(),
    };

    setState(() {
      comments.add(newCommentData);
    });
  }

  String formatarDataHora(String dataHora) {
    DateTime dateTime = DateTime.parse(dataHora);
    DateFormat formato = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');
    return formato.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: results.isNotEmpty
            ? Text(results[0]["company"]["name"],
                style: const TextStyle(color: Colors.black))
            : const SizedBox.shrink(),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 275,
              child: PageView.builder(
                itemCount: 3,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    selectedPage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return Image.asset(
                    'assets/imgs/produto.jpeg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PageViewDotIndicator(
                currentItem: selectedPage,
                count: 3,
                unselectedColor: Colors.black26,
                selectedColor: Colors.blue,
                duration: const Duration(milliseconds: 200),
                boxShape: BoxShape.circle,
              ),
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  results.isNotEmpty
                      ? Text(
                          results[0]["product"]["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      : const SizedBox.shrink(),
                  results.isNotEmpty
                      ? Text(results[0]["product"]["description"])
                      : const SizedBox.shrink(),
                  results.isNotEmpty
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "R\$ ${results[0]["product"]["price"].toString()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                              size: 16,
                            ),
                            Text(results[0]["likes"].toString())
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            const Text(
              "Comentários",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextField(
              controller: CommentController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Digite aqui seu comentário...',
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (newComment.isNotEmpty) {
                      addComment(newComment);
                      setState(() {
                        CommentController.clear();
                        newComment = '';
                      });
                    }
                  },
                  child: const Icon(Icons.send),
                ),
              ),
              onChanged: (comment) {
                setState(() {
                  newComment = comment;
                });
              },
            ),
            ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comments[index]["content"]),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            comments[index]["user"]["name"],
                          ),
                          const SizedBox(width: 16),
                          Text(
                            formatarDataHora(comments[index]["datetime"]),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
