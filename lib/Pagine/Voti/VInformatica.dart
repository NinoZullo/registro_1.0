/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/mysql/DBMetodi.dart';

class VInformatica extends StatefulWidget {
  const VInformatica({Key? key}) : super(key: key);

  @override
  State<VInformatica> createState() => _VInformaticaState();
}

class _VInformaticaState extends State<VInformatica> {
  List<Map<String, dynamic>>? voti;
  DBMetodi db = DBMetodi();

  @override
  void initState() {
    super.initState();
    db.getVoti().then((value) {
      setState(() {
        voti = value;
        print(voti);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informatica",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 100.h),
          Expanded(
            child: ListView.builder(
              itemCount: voti?.length ?? 0,
              itemBuilder: (context, index) {
                final voto = voti![index];
                final votoString = voto['voto'].toString();
                final dataString = voto['data_inserimento'].toString();
                final descrizione = voto['descrizione'].toString();

                final votoDouble = double.tryParse(votoString) ?? 0.0;
                final data = DateTime.tryParse(dataString) ?? DateTime.now();

                return ContainerVoti(
                  Voto: votoDouble,
                  Data: data,
                  Descrizione: descrizione,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


