// ignore_for_file: must_be_immutable, avoid_print
import 'dart:io';

import 'package:flutter/material.dart';
import './main.dart';
import './email.dart';

class ConfigsScreen extends StatefulWidget {
  const ConfigsScreen({super.key});
  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
  void apagarFotos() async {
    int i = 1;
    while (i <= dadosBox.getAll().length) {
      print(dadosBox.get(i)!.fotoPath);
      await File(dadosBox.get(i)!.fotoPath).delete();
      i++;
    }
  }

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
                      Icones(const Icon(Icons.arrow_circle_left_outlined,
                          color: Colors.white, size: 40))
                    ]))),
        body: Center(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 90, horizontal: 30),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 300),
                    child: FloatingActionButton.extended(
                        onPressed: () {
                          Future<void> showMyDialog() async {
                            return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return const Enviar();
                                });
                          }

                          showMyDialog();
                        },
                        backgroundColor: const Color.fromRGBO(0, 108, 181, 1),
                        label: const Text(
                          'Enviar dados',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  FloatingActionButton.extended(
                      onPressed: () {
                        Future<void> showMyDialog() async {
                          return showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return const Confirmar();
                              });
                        }

                        showMyDialog();
                      },
                      backgroundColor: const Color.fromRGBO(0, 108, 181, 1),
                      label: const Text('Excluir dados',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))
                ]))));
  }
}

class Confirmar extends StatelessWidget {
  const Confirmar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir dados'),
      content: const Text(
        'Tem certeza que deseja excluir todos os dados?',
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Não', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.pop(context, 'Não');
          },
        ),
        TextButton(
          child: const Text('Sim', style: TextStyle(fontSize: 18)),
          onPressed: () {
            dadosBox.removeAll();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyApp()));
          },
        ),
      ],
    );
  }
}

class Enviar extends StatelessWidget {
  const Enviar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir dados'),
      content: const Text(
        'Tem certeza que deseja enviar os dados?',
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Não', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.pop(context, 'Não');
          },
        ),
        TextButton(
          child: const Text('Sim', style: TextStyle(fontSize: 18)),
          onPressed: () {
            EmailSender email = EmailSender();
            email.send();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyApp()));
          },
        ),
      ],
    );
  }
}
