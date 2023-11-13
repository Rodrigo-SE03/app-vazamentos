import 'package:ar_comprimido/help.dart';
import 'package:flutter/material.dart';
import './main.dart';

class Referencias extends StatelessWidget {
  const Referencias({super.key});

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
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HelpScreen()));
                          },
                          icon: const Icon(Icons.arrow_circle_left_outlined,
                              color: Colors.white, size: 40))
                    ]))),
        body: Center(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 160,
                      child: ListView(shrinkWrap: true, children: [
                        Itens('engate_rapido', 'Conexão de Engate Rápido'),
                        Itens('valvula_solenoide', 'Válvula Solenoide')
                      ]))
                ]))));
  }
}

// ignore: must_be_immutable
class Itens extends StatelessWidget {
  String imagem;
  String componente;
  Itens(this.imagem, this.componente, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: 90,
            height: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/componentes/$imagem.png')))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    componente,
                    textAlign: TextAlign.left,
                    style: titleFont(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
