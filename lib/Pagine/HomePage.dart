import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Annotazioni.dart';
import 'package:registro/Pagine/Argomenti.dart';
import 'package:registro/Pagine/Assenze.dart';
import 'package:registro/Pagine/Calendario.dart';
import 'package:registro/Pagine/Compiti.dart';
import 'package:registro/Pagine/NoteDisciplinari.dart';
import 'package:registro/Pagine/PCTO.dart';
import 'package:registro/Pagine/Profilo.dart';
import 'package:registro/Pagine/Voti.dart';
import 'package:registro/Pagine/menu.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/Pagine/PaginaLogin.dart';
import 'package:registro/mysql/Utente.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  Brightness _currentBrightness = Brightness.light;
  bool _isDarkMode = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTheme() {
    setState(() {
      _currentBrightness = _isDarkMode ? Brightness.dark : Brightness.light;
    });
  }
  int calculateRemainingDays() {
    final now = DateTime.now();
    final targetDate = DateTime(now.year, 6, 8);
    final difference = targetDate.difference(now);
    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    int remainingDays = calculateRemainingDays();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          DayNightSwitcher(
            isDarkModeEnabled: _isDarkMode,
            onStateChanged: (isDarkModeEnabled) {
              setState(() {
                _isDarkMode = isDarkModeEnabled;
              });
              _toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaginaLogin(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 40.w),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$nome_ $cognome_",
                      style: TextStyle(
                          fontSize: 20.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Studente",
                      style: TextStyle(fontSize: 16.w, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              width: 600.w,
              height: 75.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(left: 10.w, top: 10.w, bottom: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assenze",
                          style: TextStyle(fontSize: 15.w, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 25.w),
                          child: Text(
                            "0",
                            style:
                            TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  VerticalDivider(
                    color: Colors.grey,
                    width: 1.w,
                    thickness: 1.h,
                    indent: 10.h,
                    endIndent: 10.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 25.w, top: 10.w, bottom: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ore PCTO",
                          style: TextStyle(fontSize: 15.w, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 23.w),
                          child: Text(
                            "12",
                            style:
                            TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  VerticalDivider(
                    color: Colors.grey,
                    width: 1.w,
                    thickness: 1.h,
                    indent: 10.h,
                    endIndent: 10.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 10.w, top: 10.w, bottom: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Giorni rimanenti",
                          style: TextStyle(fontSize: 14.w, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 50.w),
                          child: Text(
                            "$remainingDays",
                            style:
                            TextStyle(fontSize: 15.w, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Voti()),
                      );
                    },
                    child: Cont1(Colors.red, Icons.auto_graph, "Voti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Assenze()),
                      );
                    },
                    child: Cont1(Colors.orange, Icons.no_accounts_sharp, "Assenze"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Compiti()),
                      );
                    },
                    child: Cont1(Colors.yellow, Icons.person_2_outlined, "Compiti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NoteDisciplinari()),
                      );
                    },
                    child: Cont1(Colors.green, Icons.beenhere_sharp, "Note"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Argomenti()),
                      );
                    },
                    child: Cont1(Colors.blue, Icons.edit, "Argomenti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Annotazioni()),
                      );
                    },
                    child: Cont1(Colors.purple, Icons.account_balance, "Annotaz."),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Cont2("Verifica di Italiano"),
                  SizedBox(height: 5),
                  Cont2("Verifica di matematica"),
                  SizedBox(height: 5),
                  Cont2("Uscita didattica"),
                  SizedBox(height: 5),
                  Cont2("Verifica di sistemi"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          It("Calendario", Icons.calendar_month),
          It("Menù", Icons.menu),
          It("Home", Icons.home),
          It("PCTO", Icons.engineering),
          It("Profilo", Icons.person),
        ],
        onTap: (currentIndex) {
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
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PCTO(),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class Cont1 extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  const Cont1(this.color, this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40.w),
          SizedBox(height: 10.h),
          Text(
            text,
            style: TextStyle(fontSize: 14.w, color: Colors.black),
          ),
        ],
      ),
    );
  }
}