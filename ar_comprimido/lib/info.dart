// ignore_for_file: prefer_const_constructors

import 'package:ar_comprimido/help.dart';
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
              'Limite de envio',
              style: titleFont(size: 25, cor: Color.fromARGB(255, 1, 30, 124)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Existe um limite de registros que pode ser enviado por e-mail, devido ao tamanho do arquivo .zip criado. Caso o arquivo ultrapasse o limite aceito pelo e-mail, é possível acessá-lo pela memória do celular. O arquivo fica salvo na pasta "Documents" e possui o nome "dados_{dia do envio}-{mês do envio}.zip". O maior número de registros testado até o momento foi de 100 registros, e não superou o tamanho limite do e-mail.',
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
        ])));
  }
}
