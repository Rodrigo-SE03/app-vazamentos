import 'package:flutter/material.dart';
import 'package:ar_comprimido/main.dart';
import 'package:ar_comprimido/dados.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';

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
            style: TextStyle(fontSize: 25),
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
                textAlign: TextAlign.center, style: TextStyle(fontSize: 14))
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
