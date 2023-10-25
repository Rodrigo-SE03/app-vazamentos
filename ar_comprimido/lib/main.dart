import 'dart:io';

import 'package:ar_comprimido/adicionar.dart';
import 'package:ar_comprimido/configs.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';
import 'package:ar_comprimido/edit.dart';
import 'package:flutter/material.dart';
import './database/objectbox_databse.dart';
import './dados.dart';

final dadosBox = objectbox.store.box<Dados>();
// ignore: constant_identifier_names
const cor_senai = Color.fromRGBO(0, 108, 181, 1);

TextStyle titleFont({Color cor = cor_senai, double size = 20}) {
  return TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: cor);
}

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
        colorScheme: ColorScheme.fromSeed(seedColor: cor_senai),
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
                MaterialPageRoute(builder: (context) => const AddScreen()));
          } else if (icon.icon == settings.icon) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ConfigsScreen()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyApp()));
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
          Padding(padding: EdgeInsets.all(10), child: ListaRegistros())
        ]));
  }
}

class ListaRegistros extends StatefulWidget {
  const ListaRegistros({
    super.key,
  });

  @override
  State<ListaRegistros> createState() => _ListaRegistrosState();
}

class _ListaRegistrosState extends State<ListaRegistros> {
  List<Dados> atualizarRegistros() {
    Query<Dados> query = dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
    return query.find();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 108,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 90,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                              File(atualizarRegistros()[index].fotoPath))))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        atualizarRegistros()[index].local,
                        textAlign: TextAlign.left,
                        style: titleFont(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(atualizarRegistros()[index].tag.toString(),
                          textAlign: TextAlign.left,
                          style: titleFont(cor: Colors.black)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_outlined,
                        color: cor_senai, size: 40),
                    onPressed: () {
                      Dados item = atualizarRegistros()[index];
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => EditScreen(item: item)));
                    }),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: dadosBox.getAll().length,
      ),
    );
  }
}
