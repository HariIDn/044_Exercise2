import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  const FormFooter({
    super.key,
    required this.onPressedImage,
    required this.onPressedSave,
  });

  final VoidCallback onPressedImage;
  final VoidCallback onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: onPressedImage,
          child: Text('Pilih Gambar'),
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: onPressedSave,
          child: Text('Simpan'),
        ),
      ],
    );
  }
}
