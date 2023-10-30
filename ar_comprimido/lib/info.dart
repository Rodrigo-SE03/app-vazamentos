// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './main.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

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
            child: ListView(shrinkWrap: false, children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Text(
              'Guia para uso do aplicativo',
              style: titleFont(size: 25, cor: Color.fromARGB(255, 1, 30, 124)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Este aplicativo possui as funcionalidades de registrar pontos de fuga de ar comprimido e enviar os dados registrados por e-mail.\nOs dados salvos a cada registro ficam armazendaos na memória interna do aparelho até o momento de serem enviados. As fotos tiradas são também salvas na galeria para que haja uma possibilidade de recuperação em caso de falha no funcionamento do aplicativo.',
              style: bodyFont(),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Text(
              'Envio de dados',
              style: titleFont(size: 25, cor: Color.fromARGB(255, 1, 30, 124)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Para enviar os dados é necessário acessar a tela de configurações por meio do ícone de engrenagem presente na tela principal. Ao pressionar a opção "Enviar Dados", você será redirecionado ao rascunho do e-mail.\nEsse rascunho terá como assunto a data de envio e nele estará anexado um arquivo compactado contendo todas as fotos tiradas e um arquivo Excel com os dados dos registros.',
              style: bodyFont(),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Text(
              'Exclusão de dados',
              style: titleFont(size: 25, cor: Color.fromARGB(255, 1, 30, 124)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Para apagar os dados salvos, basta ir na tela de configurações e pressionar a opção "Excluir Dados". Essa opção apagará todos os registros e fotos, o que pode levar algum tempo dependendo da quantidade de elementos registrados.\nAlgumas coisas ficarão salvas na memória cache do aplicativo. Para removê-las é necessário acessar os dados do aplicativo e excluir a memória cache e dados salvos.',
              style: bodyFont(),
              textAlign: TextAlign.justify,
            ), //Seria bom colocar uma imagem disso nessa parte
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Text(
              'Exclusão de um único registro',
              style: titleFont(size: 25, cor: Color.fromARGB(255, 1, 30, 124)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'É possível excluir um único elemento da lista de registros caso necessário. Para isso, basta ir na tela principal e pressionar a seta à direita do item que se deseja excluir. Isso o direcionará a uma tela contendo as informações do registro. Nessa tela, haverá um ícone de lixeira na parte superior, o qual apagará o registro.',
              style: bodyFont(),
              textAlign: TextAlign.justify,
            ),
          ),
        ])));
  }
}
