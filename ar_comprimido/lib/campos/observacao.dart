import 'package:flutter/material.dart';
import 'package:ar_comprimido/main.dart';
import 'package:ar_comprimido/dados.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';

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
            "Observação",
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
