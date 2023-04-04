import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final String nomeEmpresa;
  final String nomeProduto;
  final String descricaoProduto;
  final double precoProduto;
  final int likes;
  const FeedCard({
    Key? key,
    required this.nomeEmpresa,
    required this.nomeProduto,
    required this.descricaoProduto,
    required this.precoProduto,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/imgs/produto.jpeg'),
          ListTile(
            leading:
                CircleAvatar(child: Image.asset('assets/imgs/avatar.jpeg')),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 10.0),
              child: Text(
                nomeEmpresa,
                style: const TextStyle(fontSize: 17),
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              nomeProduto,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 100,
              child: Text(descricaoProduto),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "R\$$precoProduto",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.favorite_rounded,
                  size: 16,
                ),
                Text(
                  likes.toString(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
