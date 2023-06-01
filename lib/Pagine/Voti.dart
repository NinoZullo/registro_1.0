import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/Pagine/InfoVoto.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class Voti extends StatefulWidget {
  const Voti({Key? key}) : super(key: key);

  @override
  State<Voti> createState() => _VotiState();
}

class _VotiState extends State<Voti> {
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
          "Voti",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Text("$nome_ $cognome_", style: TextStyle(fontSize: 20.sp , fontWeight: FontWeight.bold , color: Colors.black),),
          SizedBox(height: 30.h),
          Expanded(
            child: ListView.builder(
              itemCount: voti?.length ?? 0,
              itemBuilder: (context, index) {
                final voto = voti![index];
                final votoString = voto['voto'].toString();
                final dataString = voto['data_inserimento'].toString();
                final materia = voto['nome_materia'].toString();

                final votoDouble = double.tryParse(votoString) ?? 0.0;
                final data = DateTime.tryParse(dataString) ?? DateTime.now();
                final formattedDate = "${data.day}-${data.month}-${data.year}";

                Color dotColor;
                if (votoDouble >= 1 && votoDouble < 5) {
                  dotColor = Colors.red;
                } else if (votoDouble >= 6 && votoDouble < 9) {
                  dotColor = Colors.green;

                } else if(votoDouble >=9){
                  dotColor = Colors.blue;
                } else {
                  dotColor = Colors.orange;
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoVoto(
                          voto: voto,
                          formattedDate: formattedDate,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              votoString,
                              style: TextStyle(
                                fontSize: 16.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$materia",
                              style: TextStyle(
                                fontSize: 16.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Data: $formattedDate",
                              style: TextStyle(
                                fontSize: 14.w,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
