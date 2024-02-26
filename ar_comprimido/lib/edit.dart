import 'dart:io';

import 'package:ar_comprimido/dados.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import './main.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.item});
  final Dados item;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
                          Future<void> showMyDialog() async {
                            return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return Excluir(item: widget.item);
                                });
                          }

                          showMyDialog();
                        },
                        icon: const Icon(Icons.delete,
                            color: Colors.white, size: 40)),
                    Icones(const Icon(Icons.arrow_circle_left_outlined,
                        color: Colors.white, size: 40))
                  ]))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Local:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.local}",
                  style: titleFont(cor: Colors.black),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Componente:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.componente}",
                  style: titleFont(cor: Colors.black),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Classificação:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.classificacao}",
                  style: titleFont(cor: Colors.black),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Quantidade:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.qtd}",
                  style: titleFont(cor: Colors.black),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Data:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.data}",
                  style: titleFont(cor: Colors.black),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Observações:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.obs}",
                  style: titleFont(cor: Colors.black),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Foto:',
                  style: titleFont(size: 25),
                ),
                Container(
                    width: 200,
                    height: 250,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.fill,
                    //         image: FileImage(File(widget.item.fotoPath))))
                    child: Image(image: FileImage(File(widget.item.fotoPath)))),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'ID:',
                  style: titleFont(size: 25),
                ),
                Text(
                  "\t\t${widget.item.tag}",
                  style: titleFont(cor: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Excluir extends StatefulWidget {
  const Excluir({super.key, required this.item});
  final Dados item;

  @override
  State<Excluir> createState() => _ExcluirState();
}

class _ExcluirState extends State<Excluir> {
  bool isLoading = false;

  void deletar() async {
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
            final fotoNome =
                file.path.split('/')[file.path.split('/').length - 1];
            final fotoDelete = "${widget.item.tag}.jpg";
            if (fotoNome == fotoDelete) {
              await file.delete();
              // ignore: use_build_context_synchronously
              if (Platform.isAndroid) {
                await PhotoManager.editor.android.removeAllNoExistsAsset();
              }
              setState(() {
                isLoading = false;
              });
            }
          }
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir item'),
      content: const Text(
        'Tem certeza que deseja excluir esse item?',
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
                  deletar();
                  dadosBox.remove(widget.item.id);
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
