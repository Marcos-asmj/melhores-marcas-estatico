import 'package:flutter/material.dart';
import 'package:marcas_estatico/detalhes.dart';

class FeedCard extends StatelessWidget {
  final List<dynamic> feed;
  const FeedCard({
    Key? key,
    required this.feed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detalhes(feedId: feed[0]["_id"]),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/imgs/produto.jpeg'),
            ListTile(
              leading:
                  CircleAvatar(child: Image.asset('assets/imgs/avatar.jpeg')),
              title: Text(
                feed[0]["company"]["name"],
                style: const TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                feed[0]["product"]["name"],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 100,
                child: Text(
                  feed[0]["product"]["description"],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      feed[0]["product"]["price"].toString(),
                      //"R\$$precoProduto",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    Icons.favorite_rounded,
                    size: 16,
                  ),
                  Text(
                    feed[0]["likes"].toString(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
