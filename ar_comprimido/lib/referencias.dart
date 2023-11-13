import 'package:ar_comprimido/help.dart';
import 'package:flutter/material.dart';
import './main.dart';

class Referencias extends StatelessWidget {
  const Referencias({super.key});

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
        body: const Center(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 90, horizontal: 30),
                child: Column(children: []))));
  }
}
