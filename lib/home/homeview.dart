import 'package:exe2/form/screen/form_screen.dart';
import 'package:exe2/kuliner/controller/kuliner_controller.dart';
import 'package:exe2/kuliner/model/kuliner.dart';
import 'package:flutter/material.dart';

import '../form/screen/detail_screen.dart';
import '../form/widget/form_edit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KulinerController _controller = KulinerController();

  @override
  void initState() {
    super.initState();
    _controller.getPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tempat'),
      ),
      body: FutureBuilder(
        future: _controller.getPlace(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kuliner kuliner = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                    kuliner: Kuliner(
                                  id: kuliner.id,
                                  nama_tempat: kuliner.nama_tempat,
                                  alamat: kuliner.alamat,
                                  foto: kuliner.foto,
                                  kuliner: kuliner.kuliner,
                                ))));
                  },
                  child: ListTile(
                    title: Text(kuliner.nama_tempat),
                    subtitle: Text(kuliner.alamat),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(kuliner.foto),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditForm(
                                        kuliner: Kuliner(
                                            id: kuliner.id,
                                            nama_tempat: kuliner.nama_tempat,
                                            alamat: kuliner.alamat,
                                            foto: kuliner.foto,
                                            kuliner: kuliner.kuliner))));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: Text('Hapus Data ini??'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            await _controller.deleteKuliner(
                                                kuliner.id! as String);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Hapus')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Batal')),
                                    ],
                                  );
                                }));
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
