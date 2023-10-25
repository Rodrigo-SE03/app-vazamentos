// ignore_for_file: must_be_immutable, avoid_print
import 'dart:io';

import 'package:flutter/material.dart';
import './main.dart';
import 'package:photo_manager/photo_manager.dart';
import './email.dart';

class ConfigsScreen extends StatefulWidget {
  const ConfigsScreen({super.key});
  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
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
                      Icones(const Icon(Icons.arrow_circle_left_outlined,
                          color: Colors.white, size: 40))
                    ]))),
        body: Center(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 90, horizontal: 30),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 300),
                    child: FloatingActionButton.extended(
                        heroTag: 'send',
                        onPressed: () {
                          Future<void> showMyDialog() async {
                            return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return const Enviar();
                                });
                          }

                          showMyDialog();
                        },
                        backgroundColor: cor_senai,
                        label: const Text(
                          'Enviar dados',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  FloatingActionButton.extended(
                      heroTag: 'delete',
                      onPressed: () async {
                        Future<void> showMyDialog() async {
                          return showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return const Confirmar();
                              });
                        }

                        showMyDialog();
                      },
                      backgroundColor: const Color.fromRGBO(0, 108, 181, 1),
                      label: const Text('Excluir dados',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))
                ]))));
  }
}

class Confirmar extends StatefulWidget {
  const Confirmar({
    super.key,
  });

  @override
  State<Confirmar> createState() => _ConfirmarState();
}

class _ConfirmarState extends State<Confirmar> {
  bool isLoading = false;

  void apagarFotos() async {
    setState(() {
      isLoading = true;
    });
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
    for (AssetPathEntity element in paths) {
      if ("Vazamentos" == element.name) {
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
            await file.delete();
          }
        }
        // ignore: use_build_context_synchronously
        if (Platform.isAndroid) {
          await PhotoManager.editor.android.removeAllNoExistsAsset();
        }
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir dados'),
      content: const Text(
        'Tem certeza que deseja excluir todos os dados?',
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        !isLoading
            ? TextButton(
                child: const Text('Não', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.pop(context, 'Não');
                },
              )
            : const Text(''),
        !isLoading
            ? TextButton(
                child: const Text('Sim', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  apagarFotos();
                  dadosBox.removeAll();
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

class Enviar extends StatelessWidget {
  const Enviar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir dados'),
      content: const Text(
        'Tem certeza que deseja enviar os dados?',
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Não', style: TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.pop(context, 'Não');
          },
        ),
        TextButton(
          child: const Text('Sim', style: TextStyle(fontSize: 18)),
          onPressed: () async {
            EmailSender email = EmailSender();
            await email.delete();
            await email.zipper();
            await email.send();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyApp()));
          },
        ),
      ],
    );
  }
}
