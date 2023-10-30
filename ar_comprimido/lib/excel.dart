import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:io';
import 'package:ar_comprimido/main.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import './dados.dart';

class Excel {
  Future<File> createExcel() async {
    final Workbook workbook = Workbook();
    final List<String> cabecalho = [
      'Foto',
      'Local',
      'Componente',
      'Classificação',
      'Data',
      'Quantidade',
      'Observações'
    ];
    final List<String> colunas = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    final Worksheet sheet = workbook.worksheets[0];
    final Query<Dados> query =
        dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
    final itens = query.find();
    final int size = itens.length;

    for (int i = 0; i < colunas.length; i++) {
      sheet.getRangeByName('${colunas[i]}1').setText(cabecalho[i]);
    }

    for (int i = 0; i < size; i++) {
      sheet.getRangeByName('A${i + 2}').setNumber(itens[i].tag.toDouble());
      sheet.getRangeByName('B${i + 2}').setText(itens[i].local);
      sheet.getRangeByName('C${i + 2}').setText(itens[i].componente);
      sheet.getRangeByName('D${i + 2}').setText(itens[i].classificacao);
      sheet.getRangeByName('E${i + 2}').setText(itens[i].data);
      sheet.getRangeByName('F${i + 2}').setText(itens[i].qtd);
      sheet.getRangeByName('G${i + 2}').setText(itens[i].obs);
    }

    final List<int> bytes = workbook.saveAsStream();
    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    File arquivo = File('$path/Vazamentos.xlsx');
    await arquivo.writeAsBytes(bytes);
    workbook.dispose();
    return arquivo;
  }
}
