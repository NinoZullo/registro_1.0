import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Calendario.dart';
import 'package:registro/Pagine/HomePage.dart';
import 'package:registro/Pagine/PCTO.dart';
import 'package:registro/Pagine/menu.dart';
import 'package:registro/Palette/Palette.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/mysql/Utente.dart';
import 'package:intl/intl.dart';

class profilo extends StatefulWidget {
  const profilo({Key? key}) : super(key: key);

  @override
  State<profilo> createState() => _profiloState();
}

class _profiloState extends State<profilo> {
  int calcolaEta(DateTime dataDiNascita) {
  DateTime dataCorrente = DateTime.now();
  int eta = dataCorrente.year - dataDiNascita.year;
  if (dataCorrente.month < dataDiNascita.month ||
  (dataCorrente.month == dataDiNascita.month && dataCorrente.day < dataDiNascita.day)) {
  eta--;
  }
  return eta;
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  double _headerHeight = 100.h;
  EdgeInsetsGeometry _rowPadding =
      EdgeInsets.only(top: 30.h, left: 15.h, right: 10.h);
  int _currentIndex = 2;
  bool isAttive = false;
  bool isChecked = false;
  bool isDarkMode = false;

  Widget customButton(
    BuildContext context,
    Color color,
    String text,
    Widget destination,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        width: 160.0.w,
        height: 90.0.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.4),
                      color.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Studente',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Column(
                      children: [
                        Prof("Nome", "$nome_"),
                        SizedBox(height: 20.h),
                        Prof("Cognome", "$cognome_"),
                        SizedBox(height: 20.h),
                        Prof("Classe", "$classe_"),
                        SizedBox(height: 20.h),
                      Prof("Età", calcolaEta(dataDiNascita_!).toString()),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Data di nascita",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        DateFormat('dd/MM/yyyy').format(dataDiNascita_!),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        items: [
          It("Calendario", Icons.calendar_month),
          It("Menù", Icons.menu),
          It("Home", Icons.home),
          It("PCTO", Icons.engineering),
          It("Profilo", Icons.person),
        ],
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
          switch (currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Calendario(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => menu(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PCTO(),
                ),
              );
              break;
          }
        },
        selectedItemColor: blu1,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
