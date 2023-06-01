import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/Palette/Palette.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';
import 'package:intl/intl.dart';

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
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    assenze = await db.getAssenze(idUtente_);
    assenzeGiustificate = assenze?.where((assenza) => assenza['giustificata'] == 1).toList();
    assenzeNonGiustificate = assenze?.where((assenza) => assenza['giustificata'] == 0).toList();
    assenzeGiustificate?.sort((a, b) => a['data_inizio'].compareTo(b['data_inizio']));
    assenzeNonGiustificate?.sort((a, b) => a['data_inizio'].compareTo(b['data_inizio']));
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
                  backgroundColor: blu1,
                  child: Icon(
                    Icons.person,
                    size: 50.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Text("$nome_ $cognome_", style: TextStyle(color: Colors.black , fontSize: 18.sp),),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 265.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: (assenzeGiustificate ?? []).map((assenza) {
                        final dataInizio = _dateFormat.format(assenza['data_inizio']);
                        final dataFine = _dateFormat.format(assenza['data_fine']);
                        return ListTile(
                          leading: CircleAvatar(
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
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 265.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: (assenzeNonGiustificate ?? []).map((assenza) {
                        final dataInizio = _dateFormat.format(assenza['data_inizio']);
                        final dataFine = _dateFormat.format(assenza['data_fine']);
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
                      }).toList(),
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
