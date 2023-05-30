import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class Assenze extends StatefulWidget {
  const Assenze({Key? key}) : super(key: key);

  @override
  State<Assenze> createState() => _AssenzeState();
}

class _AssenzeState extends State<Assenze> {
  List<Map<String, dynamic>>? assenze;
  List<Map<String, dynamic>>? assenzeGiustificate;
  List<Map<String, dynamic>>? assenzeNonGiustificate;
  DBMetodi db = DBMetodi();
  double _headerHeight = 100.h;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    assenze = await db.getAssenze(idUtente_);
    assenzeGiustificate = assenze?.where((assenza) => assenza['giustificata'] == 1).toList();
    assenzeNonGiustificate = assenze?.where((assenza) => assenza['giustificata'] == 0).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assenze"),
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
                  backgroundColor: Colors.deepPurple,
                  child: Icon(
                    Icons.person,
                    size: 50.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Assenze giustificate:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 265.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: assenzeGiustificate?.map((assenza) {
                        final dataInizio = assenza['data_inizio'].toString();
                        final dataFine = assenza['data_fine'].toString();
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                          title: Text(
                            '$dataInizio - $dataFine',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Assenze non giustificate:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 265.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: assenzeNonGiustificate?.map((assenza) {
                        final dataInizio = assenza['data_inizio'].toString();
                        final dataFine = assenza['data_fine'].toString();
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                          ),
                          title: Text(
                            '$dataInizio - $dataFine',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
