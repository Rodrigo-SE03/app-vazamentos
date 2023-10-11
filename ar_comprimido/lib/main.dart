import 'package:ar_comprimido/adicionar.dart';
import 'package:ar_comprimido/configs.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';
import 'package:flutter/material.dart';
import './database/objectbox_databse.dart';
import './dados.dart';

final dadosBox = objectbox.store.box<Dados>();

late ObjectBox objectbox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(1, 78, 129, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

// ignore: must_be_immutable
class Icones extends StatelessWidget {
  Icon icon;
  final Icon add = const Icon(Icons.add_circle_outline_rounded,
      color: Colors.white, size: 40);
  final Icon settings =
      const Icon(Icons.settings, color: Colors.white, size: 40);
  Box<Dados>? dadosBox;
  Icones(this.icon, {super.key, this.dadosBox});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (icon.icon == add.icon) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AddScreen()));
          } else if (icon.icon == settings.icon) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ConfigsScreen()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyApp()));
          }
        },
        icon: icon);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
                backgroundColor: const Color.fromRGBO(0, 108, 181, 1),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('assets/images/senai_logo.png',
                          fit: BoxFit.contain, height: 50),
                      Icones(const Icon(Icons.settings,
                          color: Colors.white, size: 40)),
                      Icones(const Icon(Icons.add_circle_outline_rounded,
                          color: Colors.white, size: 40))
                    ]))),
        body: const Column(children: [
          Padding(padding: EdgeInsets.all(10), child: Text('Hola'))
        ]));
  }
}
