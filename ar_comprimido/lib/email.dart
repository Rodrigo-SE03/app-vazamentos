// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:ar_comprimido/main.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ar_comprimido/database/objectbox.g.dart';
import './dados.dart';
import './excel.dart';
import 'package:archive/archive_io.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EmailSender {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  Future<void> delete() async {
    try {
      await File(
              '/data/user/0/com.example.ar_comprimido/app_flutter/dados_${DateTime.now().day}-${DateTime.now().month}.zip')
          .delete();
    } on PathNotFoundException {
      print('Sem arquivo');
    }
  }

  Future<void> zipper() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Query<Dados> query = dadosBox.query(Dados_.tag.greaterOrEqual(0)).build();
    List<Dados> itens = query.find();
    var encoder = ZipFileEncoder();
    encoder.create(
        '${dir.path}/dados_${DateTime.now().day}-${DateTime.now().month}.zip');
    int i = 0;
    while (i < itens.length) {
      encoder.addFile(File(itens[i].fotoPath));
      i++;
    }

    final Excel excel = Excel();
    final File planilha = await excel.createExcel();
    encoder.addFile(planilha);

    encoder.close();
  }

  Future<bool> send() async {
    final Email email = Email(
      body: '',
      subject:
          'Registros de Vazamentos - ${DateTime.now().day}/${DateTime.now().month}',
      recipients: [''],
      attachmentPaths: [
        '/data/user/0/com.example.ar_comprimido/app_flutter/dados_${DateTime.now().day}-${DateTime.now().month}.zip',
      ],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      return true;
    } catch (error) {
      return false;
    }
  }
}
