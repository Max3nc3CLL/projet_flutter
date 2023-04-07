import 'package:flutter/material.dart';
import 'main.dart';


class Stalks extends StatefulWidget {
  const Stalks({Key? key}) : super(key: key);

  @override
  State<Stalks> createState() => _StalksState();
}

class _StalksState extends State<Stalks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retour'),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.yellow,
                width: 1,
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'page',)),
            );
          },
        ),
      ),
    );
  }
}
