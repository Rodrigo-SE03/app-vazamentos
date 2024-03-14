import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Foto extends StatefulWidget {
  const Foto({super.key, required this.fotografia});
  final ValueChanged<File?> fotografia;
  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile =
        await imagePicker.pickImage(source: source, imageQuality: 20);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        widget.fotografia(imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Foto",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          ),
        ),
        SizedBox(
          width: 230,
          height: 230,
          child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage:
                  imageFile != null ? FileImage(imageFile!) : null),
        ),
        IconButton(
          onPressed: () async {
            pick(ImageSource.camera);
          },
          icon: const Icon(Icons.camera_alt_outlined),
          iconSize: 40,
          color: Colors.black,
        )
      ],
    );
  }
}
