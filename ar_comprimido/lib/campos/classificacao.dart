import 'package:flutter/material.dart';

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
