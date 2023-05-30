import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class SelectedClass extends StatefulWidget {
  final String className;
  final String nomeMateria;

  SelectedClass({
    required this.className,
    required this.nomeMateria,
  });

  @override
  _SelectedClassState createState() => _SelectedClassState();
}

class _SelectedClassState extends State<SelectedClass> {
  List<Map<String, dynamic>>? studenti;
  DBMetodi db = DBMetodi();

  @override
  void initState() {
    super.initState();
    db.getStudenti(widget.className).then((value) {
      setState(() {
        studenti = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.className}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: 150.0,
        height: 200.0,
        child: ListView.builder(
          itemCount: studenti?.length ?? 0,
          itemBuilder: (context, index) {
            final studente = studenti![index];
            final idStudente = studente['id_studente'].toString();
            final nome = studente['nome'].toString();
            final cognome = studente['cognome'].toString();

            return Container(
              height: 50.0.h,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                ),
                title: Text(
                  "$nome $cognome",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
