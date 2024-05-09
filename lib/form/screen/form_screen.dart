import 'package:exe2/form/widget/form_head.dart';
import 'package:exe2/form/widget/form_ui.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var nama_tempat = TextEditingController();
  var kuliner = TextEditingController();
  var alamat = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormHead(),
            FormUI(),
          ],
        ),
      ),
    );
  }
}
