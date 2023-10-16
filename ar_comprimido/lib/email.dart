// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'package:flutter/material.dart';

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

  Future<void> send() async {
    final Email email = Email(
      body: 'Teste',
      subject: 'Teste',
      recipients: ['sujeito300@gmail.com'],
      attachmentPaths: [],
      isHTML: false,
    );
    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
      print(platformResponse);
    }
  }
}
