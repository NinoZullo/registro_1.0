import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/Palette/Palette.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class Annotazioni extends StatefulWidget {
  const Annotazioni({Key? key}) : super(key: key);

  @override
  State<Annotazioni> createState() => _AnnotazioniState();
}

class _AnnotazioniState extends State<Annotazioni> {
  List<Map<String, dynamic>> annotazioni = [];
  DBMetodi db = DBMetodi();
  double _headerHeight = 100.h;

  @override
  void initState() {
    super.initState();
    fetchAnnotazioni();
  }

  Future<void> fetchAnnotazioni() async {
    final fetchedAnnotazioni = await db.getAnnotazioni(idUtente_);
    setState(() {
      annotazioni = fetchedAnnotazioni ?? [];
    });
  }

  Color getColorForType(String type) {
    switch (type) {
      case '+':
        return Colors.green;
      case '-':
        return Colors.grey;
      case '*':
        return Colors.grey;
      case 'GR':
        return Colors.red;
      case 'IN':
        return Colors.redAccent;
      case 'NTS':
        return Colors.orange;
      case 'SU':
        return Colors.green;
      case 'DI':
        return Colors.green;
      case 'BU':
        return Colors.lightGreen;
      case 'DS':
        return Colors.cyan;
      case 'OT':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annotazioni"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: blu1,
                  child: Icon(
                    Icons.person,
                    size: 50.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  '$nome_ $cognome_',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Studente',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Annotazioni:',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: annotazioni.length,
                      itemBuilder: (context, index) {
                        final annotazione = annotazioni[index];
                        final iconType = annotazione['nome_corto'] as String;
                        final description = annotazione['descrizione'] as String;
                        final date = annotazione['data_inserimento'] as DateTime;
                        final teacherName = annotazione['nome'] as String;
                        final teacherSurname = annotazione['cognome'] as String;
                        final subjectName = annotazione['nome_materia'] as String;
                        final color = getColorForType(iconType);

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color,
                            child: Text(
                              iconType,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            description,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            '$teacherName $teacherSurname - $subjectName',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
