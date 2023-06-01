import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Docenti/SelectedClass.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class Classi extends StatefulWidget {
  const Classi({Key? key}) : super(key: key);

  @override
  State<Classi> createState() => _ClassiState();
}

class _ClassiState extends State<Classi> {
  List<Map<String, dynamic>>? classi;
  DBMetodi db = DBMetodi();
  @override
  void initState() {
    super.initState();
    db.getClassi().then((value) {
      setState(() {
        classi = value;
        print(classi);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classi"),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: classi?.length ?? 0,
        itemBuilder: (context, index) {
          if (classi == null) {
            return CircularProgressIndicator();
          }

          final classe = classi![index];
          // final idAssegnazione = classe['id_assegnazione'].toString();
          final nomeClasse = classe['nome_classe'].toString();
          final nomeMateria = classe['nome_materia'].toString();
          final idClasse = int.parse(classe['id_classe']);
          return Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Clas(
              context,
              Colors.cyan,
              nomeClasse,
              nomeMateria,
              SelectedClass(
                  className: nomeClasse,
                  nomeMateria: nomeMateria,
                  idClasse: idClasse),
            ),
          );
        },
      ),
    );
  }
}
