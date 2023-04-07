import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/pseudo_cubit.dart';
import '../../models/pseudo.dart';
import 'stalks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique'),
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.yellow,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20, color: Colors.yellow),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Stalks()),
                    );
                  },
                  child: const Text('Gradient'),
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            // Gestion de l'action du bouton
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow,
                  width: 1,
                ),
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Entrez un pseudo instagram',
                  border: InputBorder.none,
                ),
                controller: _textFieldController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'le champs ne doit pas être vide';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                    final String name = _textFieldController.text;
                    final Pseudo pseudo = Pseudo(0, name);
                    context.read<PseudoCubit>().addPseudo(pseudo);
                    Navigator.of(context).pop();
                  },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text('Valider'),
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
