import 'package:flutter/material.dart';

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
