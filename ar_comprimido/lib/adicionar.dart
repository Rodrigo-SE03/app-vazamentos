// ignore_for_file: avoid_print

import 'dart:io';
import 'package:ar_comprimido/database/objectbox.g.dart';
import 'package:flutter/material.dart';
import './main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:gal/gal.dart';
import './dados.dart';

import 'campos/local.dart';
import 'campos/componente.dart';
import 'campos/classificacao.dart';
import 'campos/data.dart';
import 'campos/quantidade.dart';
import 'campos/foto.dart';
import 'campos/observacao.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleControllerLocal = TextEditingController();
  final titleControllerComponente = TextEditingController();
  final titleControllerObs = TextEditingController();
  final titleControllerClass = TextEditingController();
  final titleControllerData = TextEditingController();

  int tag = 1;
  String local = "";
  String componente = "";
  String obs = "";
  String classificacao = "";
  String data = "";
  String qtd = "";
  File? foto;
  bool flagOk = false;

  void _setText() {
    atualizarDados() {
      if (local == '') {
        local = titleControllerLocal.text;
      }
      if (componente == '') {
        componente = titleControllerComponente.text;
      }
      obs = titleControllerObs.text;
      data = titleControllerData.text;

      if (classificacao == "") {
        classificacao = "Pequeno";
      }
      if (qtd == "") {
        qtd = "1";
      }
      if (data == "") {
        data =
            "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";
      }
      //print("$local $componente $classificacao $data $qtd $foto $obs");

      if (local == "" || componente == "" || foto == null) {
        flagOk = false;
        foto = File('nada');
      } else {
        flagOk = true;
        if (dadosBox.getAll().isEmpty) {
          tag = 0;
        } else {
          tag = dadosBox.getAll().length;
        }
      }
    }

    atualizarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
                backgroundColor: cor_senai,
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
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    // FloatingActionButton(onPressed: () async {
                    //   // -----
                    //   print(dadosBox.getAll());
                    //   Query<Dados> query =
                    //       dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
                    //   List<Dados> teste1 = query.find();
                    //   print(teste1[0].local);
                    //   query.close();
                    //   //Directory dir = await getApplicationDocumentsDirectory();
                    //   //Directory obxDir = Directory("${dir.path}/obx-example");
                    //   //print(obxDir.listSync());
                    //   //File obx = File("${obxDir.path}/data.mdb");
                    //   //List<String> content = await obx.readAsLines();
                    //   // print(content);
                    //   // -----
                    // }),
                    Local(
                      titleController: titleControllerLocal,
                      local: (novoLocal) {
                        local = novoLocal;
                      },
                    ), //Campo de preenchimento do Local
                    Componente(
                      titleController: titleControllerComponente,
                      componente: (novoComponente) {
                        componente = novoComponente;
                      },
                    ), //Campo de preenchimento do Componente
                    Classificacao(classificacao: (novaClassificacao) {
                      classificacao = novaClassificacao;
                    }), //Campo de preenchimento da Classificação
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Data(
                                titleControllerData:
                                    titleControllerData), //Campo de preenchimento da data
                            Quantidade(qtd: (novaQtd) {
                              qtd = novaQtd;
                            }) //Campo de preenchimento da quantidade
                          ],
                        )),
                    Foto(
                      fotografia: (novaFoto) {
                        foto = novaFoto;
                      },
                    ), //Área da fotografia
                    Observacao(
                      titleController: titleControllerObs,
                      obs: (novaObs) {
                        obs = novaObs;
                      },
                    ), //Campo de preenchimento da observação
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: FloatingActionButton.extended(
                          onPressed: () async {
                            _setText();
                            if (flagOk) {
                              String dir = path.dirname(foto!.path);
                              String newName = path.join(dir, "$tag.jpg");
                              foto = File(foto!.path).renameSync(newName);
                              XFile fotinha = XFile(foto!.path);
                              await Gal.putImage(fotinha.path, album: 'Fotos');
                            }
                            Future<void> showMyDialog(bool flagOk) async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertaDeRegistro(
                                    classificacao: classificacao,
                                    componente: componente,
                                    data: data,
                                    local: local,
                                    tag: tag,
                                    obs: obs,
                                    qtd: qtd,
                                    dadosBox: dadosBox,
                                    flagOk: flagOk,
                                    fotoPath: foto!.path,
                                  );
                                },
                              );
                            }

                            showMyDialog(flagOk);
                          },
                          backgroundColor: const Color.fromRGBO(0, 108, 181, 1),
                          label: const Text(
                            "Registrar Vazamento",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ],
                ))
          ]),
        ));
  }
}

class AlertaDeRegistro extends StatelessWidget {
  const AlertaDeRegistro(
      {super.key,
      required this.tag,
      required this.classificacao,
      required this.componente,
      required this.data,
      required this.local,
      required this.obs,
      required this.qtd,
      required this.dadosBox,
      required this.flagOk,
      required this.fotoPath});
  final int tag;
  final String classificacao;
  final String componente;
  final String data;
  final String local;
  final String obs;
  final String qtd;
  final Box<Dados> dadosBox;
  final bool flagOk;
  final String fotoPath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: flagOk
          ? const Text('Vazamento registrado')
          : const Text('Dados insuficientes'),
      content: flagOk
          ? const Text(
              'Vazamento registrado com sucesso',
              style: TextStyle(fontSize: 18),
            )
          : const Text(
              'Preencha todos os campos obrigatórios',
              style: TextStyle(fontSize: 18),
            ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK', style: TextStyle(fontSize: 18)),
          onPressed: () {
            if (flagOk) {
              final dadosUpdate = Dados(
                  classificacao: classificacao,
                  componente: componente,
                  data: data,
                  tag: tag,
                  local: local,
                  obs: obs,
                  qtd: qtd,
                  fotoPath: fotoPath);
              dadosBox.put(dadosUpdate);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyApp()));
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
