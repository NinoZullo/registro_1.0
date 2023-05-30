
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Calendario.dart';
import 'package:registro/Pagine/HomePage.dart';
import 'package:registro/Pagine/PCTO.dart';
import 'package:registro/Pagine/Profilo.dart';
import 'package:registro/Pagine/menu.dart';
import 'package:registro/Palette/Palette.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/mysql/Utente.dart';

class PCTO extends StatefulWidget {
  const PCTO({Key? key}) : super(key: key);

  @override
  State<PCTO> createState() => _PCTOState();
}

class _PCTOState extends State<PCTO> {

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
                        Row(
                          children: [
                            Text(
                              "Ore minime",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "80",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        Row(
                          children: [
                            Text(
                              "Ore effettuate:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "120",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        Row(
                          children: [
                            Text(
                              "Ore totali",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "120",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Text(
                              "Referente PCTO",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Carlo Cerri",
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => profilo(),
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
