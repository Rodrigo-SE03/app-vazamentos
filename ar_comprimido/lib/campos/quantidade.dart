import 'package:flutter/material.dart';

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
          style: TextStyle(fontSize: 25),
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