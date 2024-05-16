import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../kuliner/model/kuliner.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.kuliner,
  });

  final Kuliner kuliner;

  @override
  State<DetailScreen> createState() => _DetailScreenState(kuliner);
}

class _DetailScreenState extends State<DetailScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_tempat = TextEditingController();
  TextEditingController alamat = TextEditingController();
  ImagePicker foto = ImagePicker();

  Kuliner kuliner;
  _DetailScreenState(this.kuliner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Kuliner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Foto Kuliner"),
                    subtitle: Image(
                      image: NetworkImage(kuliner.foto),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: const Text("Tempat Kuliner"),
                    subtitle: Text(kuliner.nama_tempat),
                  ),
                  ListTile(
                    title: const Text("Alamat Kuliner"),
                    subtitle: Text(kuliner.alamat),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
