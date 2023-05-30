import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class SelectedClass extends StatefulWidget {
  final String className;
  final String nomeMateria;
  final int idClasse;
  SelectedClass({
    required this.className,
    required this.nomeMateria,
    required this.idClasse,
  });

  @override
  _SelectedClassState createState() => _SelectedClassState();
}

class _SelectedClassState extends State<SelectedClass> {
  Future<List<Map<String, dynamic>>>? studentiFuture;
  DBMetodi db = DBMetodi();

  @override
  void initState() {
    super.initState();
    studentiFuture = db.getStudenti(widget.idClasse!) as Future<List<Map<String, dynamic>>>?;
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: studentiFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching student data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No student data available'),
            );
          }

          final studenti = snapshot.data!;

          return Container(
            width: 150.0,
            height: 200.0,
            child: ListView.builder(
              itemCount: studenti.length,
              itemBuilder: (context, index) {
                final studente = studenti[index];
                final idStudente = studente['id_studente'].toString();
                final nome = studente['nome'].toString();
                final cognome = studente['cognome'].toString();

                return Container(
                  height: 50.0,
                  child: ListTile(
                    leading: CircleAvatar(
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
          );
        },
      ),
    );
  }
}
