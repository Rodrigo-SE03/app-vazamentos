import 'package:flutter/material.dart';
import 'package:ar_comprimido/main.dart';
import 'package:ar_comprimido/dados.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';

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
