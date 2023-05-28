import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/mysql.dart';
import 'package:registro/mysql/utente.dart';

class SelectedClass extends StatefulWidget {
  final String className;
  final String nome_materia;
  SelectedClass({required this.className , required this.nome_materia});

  @override
  _SelectedClassState createState() => _SelectedClassState();
}

class _SelectedClassState extends State<SelectedClass> {
  List<String> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      List<Map<String, dynamic>>? studentList = await getStudenti(idClasse_!); // devo mettere l'id della classe
      if (studentList != null) {
        List<String> studentNames = studentList
            .map((student) => '${student['nome']} ${student['cognome']}')
            .toList();
        setState(() {
          students = studentNames;
        });
      }
    } catch (e) {
  print("Errore");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.className}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Classe: ${widget.className} ',
              style: TextStyle(fontSize: 24.sp, color: Colors.black),
            ),
            SizedBox(height: 20.h),
            Text(
              "Materia: ${widget.nome_materia}",
              style: TextStyle(fontSize: 20.sp, color: Colors.black),
            ),
            Expanded(
              child: Container(
                width: 100.w,
                height: 100.h,
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        students[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
