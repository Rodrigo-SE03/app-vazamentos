// ignore_for_file: avoid_print

import 'dart:io';
import 'package:ar_comprimido/database/objectbox.g.dart';
import 'package:flutter/material.dart';
import './main.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';
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
  String fotoPath = "";
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
          tag = 1;
        } else {
          Query<Dados> query =
              dadosBox.query(Dados_.tag.greaterOrEqual(0)).order(Dados_.tag,flags: Order.descending).build();
          List<Dados> listaItens = query.find();
          tag = listaItens[0].tag + 1;
        }
      }
    }

    atualizarDados();
  }

  Future<String> pegarFoto(int tag) async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
    print(paths);
    for (AssetPathEntity element in paths) {
      if ("Vazamentos" == element.name) {
        print('1');
        int numImages = await element.assetCountAsync;
        List<AssetEntity> assets = await element.getAssetListRange(
          start: 0,
          end: numImages,
        );
        for (AssetEntity asset in assets) {
          File? file = await asset.file;
          if (file == null) {
            continue;
          } else {
            final fotoNome =
                file.path.split('/')[file.path.split('/').length - 1];
            print('2 $fotoNome');
            final fotoSave = "$tag.jpg";
            if (fotoNome == fotoSave) {
              return file.path;
            }
          }
        }
      }
    }
    return 'falhou';
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
                    // FloatingActionButton(
                    //     heroTag: 'teste',
                    //     onPressed: () async {
                    //       // -----
                    //       //print(dadosBox.getAll());
                    //       // Query<Dados> query = dadosBox
                    //       //     .query(Dados_.tag.greaterOrEqual(0))
                    //       //     .build();
                    //       // print(dadosBox
                    //       //     .query()
                    //       //     .build()
                    //       //     .property(Dados_.obs)
                    //       //     .find());
                    //       // List<Dados> teste1 = query.find();
                    //       //print(teste1[teste1.length - 1].fotoPath);
                    //       // query.close();
                    //       Directory dir =
                    //           await getApplicationDocumentsDirectory();

                    //       print(dir.listSync());
                    //       // -----
                    //     }),
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
                              await Gal.putImage(fotinha.path,
                                  album: 'Vazamentos');
                              fotoPath = await pegarFoto(tag);
                            }
                            Future<void> showMyDialog(bool flagOk) async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
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
