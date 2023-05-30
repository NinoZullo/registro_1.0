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
  List<String> annotazioni = [];
  DBMetodi db = DBMetodi();

  @override
  void initState() {
    super.initState();
    db.getAnnotazioni(idUtente_).then((value) {
      setState(() {
        annotazioni = value!.map((annotazione) => annotazione['descrizione'].toString()).toList();
        print(annotazioni);
      });
    });
  }

  double _headerHeight = 100.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annotazio"),
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
              ],
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
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: annotazioni.map((annotazione) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.purple,
                            ),
                            title: Text(
                              annotazione,
                              style: TextStyle(
                                fontSize: 16.sp,
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
          ),
        ],
      ),
    );
  }
}
