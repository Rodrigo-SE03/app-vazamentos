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
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
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
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Text(
                  "\t\t${widget.item.local}",
                  style: titleFont(cor: Colors.black),
                ),
                IconButton(onPressed: (){
                  edit_popup_text('Local',widget.item,myController);
                  },
                 icon: const Icon(Icons.create_rounded, color: cor_senai, size: 30))
                ],
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Componente:',
                  style: titleFont(size: 25),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Text(
                  "\t\t${widget.item.componente}",
                  style: titleFont(cor: Colors.black),
                ),
                IconButton(onPressed: (){
                  edit_popup_text('Componente',widget.item,myController);
                  },
                 icon: const Icon(Icons.create_rounded, color: cor_senai, size: 30))
                ],
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Classificação:',
                  style: titleFont(size: 25),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Text(
                  "\t\t${widget.item.classificacao}",
                  style: titleFont(cor: Colors.black),
                ),
                IconButton(onPressed: (){
                  edit_popup_class('Classificação',widget.item);
                  },
                 icon: const Icon(Icons.create_rounded, color: cor_senai, size: 30))
                ],
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Quantidade:',
                  style: titleFont(size: 25),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Text(
                  "\t\t${widget.item.qtd}",
                  style: titleFont(cor: Colors.black),
                ),
                IconButton(onPressed: (){
                  edit_popup_qtd('Quantidade',widget.item);
                  },
                 icon: const Icon(Icons.create_rounded, color: cor_senai, size: 30))
                ],
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
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                Text(
                  "\t\t${widget.item.obs}",
                  style: titleFont(cor: Colors.black),
                ),
                IconButton(onPressed: (){
                  edit_popup_text('Observações',widget.item,myController);
                  },
                 icon: const Icon(Icons.create_rounded, color: cor_senai, size: 30))
                ],
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Text(
                  'Foto:',
                  style: titleFont(size: 25),
                ),
                // ignore: sized_box_for_whitespace
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
    // ignore: non_constant_identifier_names
    Future edit_popup_text(String label, Dados item, TextEditingController myController){ 
      
      return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Editar $label"),
        content: TextField(decoration: const InputDecoration(hintText: 'Novo texto'), controller: myController),
        actions: [TextButton(onPressed: (){
                  Dados dadosUpdate;
                  dadosUpdate = Dados(
                  classificacao: item.classificacao,
                  componente: item.componente,
                  data: item.data,
                  tag: item.tag,
                  local: item.local,
                  obs: item.obs,
                  qtd: item.qtd,
                  fotoPath: item.fotoPath);
                  if (label == 'Local'){
                    dadosUpdate = Dados(
                    classificacao: item.classificacao,
                    componente: item.componente,
                    data: item.data,
                    tag: item.tag,
                    local: myController.text,
                    obs: item.obs,
                    qtd: item.qtd,
                    fotoPath: item.fotoPath);
                  }
                  else if (label == 'Componente'){
                    dadosUpdate = Dados(
                    classificacao: item.classificacao,
                    componente: myController.text,
                    data: item.data,
                    tag: item.tag,
                    local: item.local,
                    obs: item.obs,
                    qtd: item.qtd,
                    fotoPath: item.fotoPath);
                  }
                  else if (label == 'Observações'){
                    dadosUpdate = Dados(
                    classificacao: item.classificacao,
                    componente: item.componente,
                    data: item.data,
                    tag: item.tag,
                    local: item.local,
                    obs: myController.text,
                    qtd: item.qtd,
                    fotoPath: item.fotoPath);
                  }
                  
                  dadosBox.put(dadosUpdate);
                  dadosBox.remove(widget.item.id);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MyApp()));
            
        },
         child: const Text('Confirmar'))],
      )
      );
    }

    // ignore: non_constant_identifier_names
    Future edit_popup_class(String label, Dados item){ 
      String cla = 'Pequeno';
      return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Editar $label"),
        content: DropdownMenu(
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
              cla = selected.toString();
            },
          ),
        actions: [TextButton(onPressed: (){
                  Dados dadosUpdate;
                  dadosUpdate = Dados(
                  classificacao: cla,
                  componente: item.componente,
                  data: item.data,
                  tag: item.tag,
                  local: item.local,
                  obs: item.obs,
                  qtd: item.qtd,
                  fotoPath: item.fotoPath);
                  
                  dadosBox.put(dadosUpdate);
                  dadosBox.remove(widget.item.id);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MyApp()));
        },
         child: const Text('Confirmar'))],
      )
      );
    }

    // ignore: non_constant_identifier_names
    Future edit_popup_qtd(String label, Dados item){ 
      String selecao = '1';
      return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Editar $label"),
        content: DropdownMenu(
              width: 240,
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
              },
              initialSelection: const DropdownMenuEntry(value: '1', label: '1'),
            ),
        actions: [TextButton(onPressed: (){
                  Dados dadosUpdate;
                  dadosUpdate = Dados(
                  classificacao: item.classificacao,
                  componente: item.componente,
                  data: item.data,
                  tag: item.tag,
                  local: item.local,
                  obs: item.obs,
                  qtd: selecao,
                  fotoPath: item.fotoPath);
                  
                  dadosBox.put(dadosUpdate);
                  dadosBox.remove(widget.item.id);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MyApp()));
        },
         child: const Text('Confirmar'))],
      )
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
