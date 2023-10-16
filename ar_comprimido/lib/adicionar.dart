// ignore_for_file: avoid_print

import 'dart:io';
import 'package:ar_comprimido/database/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:gal/gal.dart';
import './dados.dart';

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

class Quantidade extends StatefulWidget {
  const Quantidade({super.key, required this.qtd});
  final ValueChanged<String> qtd;

  @override
  State<Quantidade> createState() => _QuantidadeState();
}

class _QuantidadeState extends State<Quantidade> {
  String selecao = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Quantidade",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: DropdownMenu(
              width: 100,
              hintText: '1',
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: '1', label: '1'),
                DropdownMenuEntry(value: '2', label: '2'),
                DropdownMenuEntry(value: '3', label: '3'),
                DropdownMenuEntry(value: '4', label: '4'),
                DropdownMenuEntry(value: '5', label: '5'),
                DropdownMenuEntry(value: '6', label: '6'),
                DropdownMenuEntry(value: '7', label: '7'),
                DropdownMenuEntry(value: '8', label: '8'),
                DropdownMenuEntry(value: '9', label: '9'),
                DropdownMenuEntry(value: '10', label: '10'),
              ],
              onSelected: (selected) {
                selecao = selected.toString();
                widget.qtd(selecao);
              },
              initialSelection: const DropdownMenuEntry(value: '1', label: '1'),
            ))
      ],
    );
  }
}

class Data extends StatelessWidget {
  const Data({
    super.key,
    required this.titleControllerData,
  });

  final TextEditingController titleControllerData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Data",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
            width: 120,
            child: TextField(
              controller: titleControllerData,
              decoration: InputDecoration(
                  labelText:
                      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                  border: const OutlineInputBorder()),
            ))
      ],
    );
  }
}

class Classificacao extends StatefulWidget {
  const Classificacao({
    super.key,
    required this.classificacao,
  });
  final ValueChanged<String> classificacao;
  @override
  State<Classificacao> createState() => _ClassificacaoState();
}

class _ClassificacaoState extends State<Classificacao> {
  String selecao = "";
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Classificação",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              )
            ],
          )),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: DropdownMenu(
            width: 240,
            textStyle: const TextStyle(fontSize: 20),
            hintText: 'Pequeno',
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'Pequeno', label: 'Pequeno'),
              DropdownMenuEntry(value: 'Médio', label: 'Médio'),
              DropdownMenuEntry(value: 'Grande', label: 'Grande'),
              DropdownMenuEntry(value: 'Extragrande', label: 'Extragrande')
            ],
            initialSelection:
                const DropdownMenuEntry(value: 'Pequeno', label: 'Pequeno'),
            onSelected: (selected) {
              selecao = selected.toString();
              widget.classificacao(selecao);
            },
          ))
    ]);
  }
}

class Componente extends StatefulWidget {
  const Componente({
    super.key,
    required this.componente,
    required this.titleController,
  });
  final ValueChanged<String> componente;
  final TextEditingController titleController;

  @override
  State<Componente> createState() => _ComponenteState();
}

class _ComponenteState extends State<Componente> {
  bool isChecked = false;
  List<DropdownMenuEntry> listaRepetidos = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Componente",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          Row(children: [
            Checkbox(
                value: dadosBox.getAll().isEmpty ? false : isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    if (dadosBox.getAll().isEmpty) {
                      isChecked = false;
                    } else {
                      isChecked = value!;
                    }
                    if (isChecked) {
                      Query<Dados> query =
                          dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
                      List<Dados> dadosList = query.find();
                      List<String> componentes = [];
                      int i = 0;
                      while (i < dadosList.length) {
                        if (!componentes.contains(dadosList[i].componente)) {
                          componentes.add(dadosList[i].componente);
                        }
                        i++;
                      }
                      print(componentes);
                      i = 0;
                      while (i < componentes.length) {
                        DropdownMenuEntry item = DropdownMenuEntry(
                            value: componentes[i], label: componentes[i]);
                        listaRepetidos.add(item);
                        i++;
                      }
                      query.close();
                    } else {
                      listaRepetidos.clear();
                    }
                  });
                }),
            const Text("Item Repetido",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 18))
          ])
        ],
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: isChecked
              ? ComponenteRepetido(
                  componente: widget.componente,
                  listaRepetidos: listaRepetidos,
                )
              : TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Componente de origem do vazamento"),
                ))
    ]);
  }
}

// ignore: must_be_immutable
class Local extends StatefulWidget {
  const Local({
    super.key,
    required this.local,
    required this.titleController,
  });
  final ValueChanged<String> local;
  final TextEditingController titleController;

  @override
  State<Local> createState() => _LocalState();
}

class _LocalState extends State<Local> {
  bool isChecked = false;
  List<DropdownMenuEntry> listaRepetidos = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Local",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          Row(children: [
            Checkbox(
                value: dadosBox.getAll().isEmpty ? false : isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    if (dadosBox.getAll().isEmpty) {
                      isChecked = false;
                    } else {
                      isChecked = value!;
                    }
                    if (isChecked) {
                      Query<Dados> query =
                          dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
                      List<Dados> dadosList = query.find();
                      List<String> locais = [];
                      int i = 0;
                      while (i < dadosList.length) {
                        if (!locais.contains(dadosList[i].local)) {
                          locais.add(dadosList[i].local);
                        }
                        i++;
                      }
                      i = 0;
                      while (i < locais.length) {
                        DropdownMenuEntry item = DropdownMenuEntry(
                            value: locais[i], label: locais[i]);
                        listaRepetidos.add(item);
                        i++;
                      }
                      query.close();
                    } else {
                      listaRepetidos.clear();
                    }
                  });
                }),
            const Text("Item Repetido",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 18))
          ])
        ],
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: isChecked
              ? LocalRepetido(
                  local: widget.local,
                  listaRepetidos: listaRepetidos,
                )
              : TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Lugar/Setor do vazamento"),
                ))
    ]);
  }
}

class Foto extends StatefulWidget {
  const Foto({super.key, required this.fotografia});
  final ValueChanged<File?> fotografia;
  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        widget.fotografia(imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Foto",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(
          width: 230,
          height: 230,
          child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage:
                  imageFile != null ? FileImage(imageFile!) : null),
        ),
        IconButton(
          onPressed: () async {
            pick(ImageSource.camera);
          },
          icon: const Icon(Icons.camera_alt_outlined),
          iconSize: 40,
          color: Colors.black,
        )
      ],
    );
  }
}

class Observacao extends StatefulWidget {
  const Observacao({
    super.key,
    required this.obs,
    required this.titleController,
  });
  final ValueChanged<String> obs;
  final TextEditingController titleController;

  @override
  State<Observacao> createState() => _ObservacaoState();
}

class _ObservacaoState extends State<Observacao> {
  bool isChecked = false;
  List<DropdownMenuEntry> listaRepetidos = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Local",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          Row(children: [
            Checkbox(
                value: dadosBox.getAll().isEmpty ? false : isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    if (dadosBox.getAll().isEmpty) {
                      isChecked = false;
                    } else {
                      isChecked = value!;
                    }
                    if (isChecked) {
                      Query<Dados> query =
                          dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
                      List<Dados> dadosList = query.find();
                      List<String> observacoes = [];
                      int i = 0;
                      while (i < dadosList.length) {
                        if (!observacoes.contains(dadosList[i].obs) &&
                            dadosList[i].obs != '') {
                          observacoes.add(dadosList[i].obs);
                        }
                        i++;
                      }
                      i = 0;
                      while (i < observacoes.length) {
                        DropdownMenuEntry item = DropdownMenuEntry(
                            value: observacoes[i], label: observacoes[i]);
                        listaRepetidos.add(item);
                        i++;
                      }
                      query.close();
                    } else {
                      listaRepetidos.clear();
                    }
                  });
                }),
            const Text("Item Repetido",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 18))
          ])
        ],
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: isChecked
              ? ObsRepetida(
                  obs: widget.obs,
                  listaRepetidos: listaRepetidos,
                )
              : TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Observação"),
                ))
    ]);
  }
}

class LocalRepetido extends StatefulWidget {
  const LocalRepetido(
      {super.key, required this.local, required this.listaRepetidos});
  final ValueChanged<String> local;
  final List<DropdownMenuEntry> listaRepetidos;
  @override
  State<LocalRepetido> createState() => _LocalRepetidoState();
}

class _LocalRepetidoState extends State<LocalRepetido> {
  String selecao = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: DropdownMenu(
            width: 300,
            textStyle: const TextStyle(fontSize: 20),
            hintText: '',
            dropdownMenuEntries: widget.listaRepetidos,
            initialSelection: widget.listaRepetidos[0],
            onSelected: (selected) {
              selecao = selected.toString();
              widget.local(selecao);
            },
          ))
    ]);
  }
}

class ComponenteRepetido extends StatefulWidget {
  const ComponenteRepetido(
      {super.key, required this.componente, required this.listaRepetidos});
  final ValueChanged<String> componente;
  final List<DropdownMenuEntry> listaRepetidos;
  @override
  State<ComponenteRepetido> createState() => _ComponenteRepetidoState();
}

class _ComponenteRepetidoState extends State<ComponenteRepetido> {
  String selecao = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: DropdownMenu(
            width: 300,
            textStyle: const TextStyle(fontSize: 20),
            hintText: '',
            dropdownMenuEntries: widget.listaRepetidos,
            initialSelection: widget.listaRepetidos[0],
            onSelected: (selected) {
              selecao = selected.toString();
              widget.componente(selecao);
            },
          ))
    ]);
  }
}

class ObsRepetida extends StatefulWidget {
  const ObsRepetida(
      {super.key, required this.obs, required this.listaRepetidos});
  final ValueChanged<String> obs;
  final List<DropdownMenuEntry> listaRepetidos;
  @override
  State<ObsRepetida> createState() => _ObsRepetidaState();
}

class _ObsRepetidaState extends State<ObsRepetida> {
  String selecao = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: DropdownMenu(
            width: 300,
            textStyle: const TextStyle(fontSize: 20),
            hintText: '',
            dropdownMenuEntries: widget.listaRepetidos,
            initialSelection: widget.listaRepetidos[0],
            onSelected: (selected) {
              selecao = selected.toString();
              widget.obs(selecao);
            },
          ))
    ]);
  }
}
