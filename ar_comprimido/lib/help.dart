// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ar_comprimido/info.dart';
import 'package:ar_comprimido/referencias.dart';
import './main.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
                    const EdgeInsets.only(top: 90, left: 30,right: 30),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: FloatingActionButton.extended(
                        heroTag: 'info',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const InfoScreen()));
                        },
                        backgroundColor: cor_senai,
                        label: const Text(
                          'Guia do aplicativo',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  FloatingActionButton.extended(
                    heroTag: 'refs',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Referencias()));
                    },
                    backgroundColor: cor_senai,
                    label: const Text(
                      'Fotos de referência',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100,bottom: 20),
                    child: Icon(Icons.warning_amber_rounded,
                              color: Color.fromARGB(255, 253, 0, 0), size: 40),
                  ),
                  Text('Evite fazer mais de 100 registros de uma só vez! Envie os já registrados, confirme se o envio foi bem sucedido, exclua os dados e continue a catalogar.',
                  style: bodyFont(),
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  )
                ]))));
  }
}
