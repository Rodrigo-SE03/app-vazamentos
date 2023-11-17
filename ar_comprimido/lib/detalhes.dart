import 'package:ar_comprimido/descricoes.dart';
import 'package:ar_comprimido/referencias.dart';
import 'package:flutter/material.dart';
import './main.dart';

class Detalhes extends StatelessWidget {
  String componente;
  String imagem;
  Detalhes(this.componente, this.imagem, {super.key});

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
                                  builder: (context) => const Referencias()));
                        },
                        icon: const Icon(Icons.arrow_circle_left_outlined,
                            color: Colors.white, size: 40))
                  ]))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  componente,
                  style: titleFont(size: 25),
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                ),
                Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/componentes/$imagem.png')))),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Descrição:',
                  style: titleFont(size: 25),
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                ),
                Text(
                  descricao(imagem),
                  style: bodyFont(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
