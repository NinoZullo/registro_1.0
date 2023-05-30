import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Calendario.dart';
import 'package:registro/Pagine/PCTO.dart';
import 'package:registro/Pagine/Profilo.dart';
import 'package:registro/Pagine/menu.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/Pagine/PaginaLogin.dart';
import 'package:registro/mysql/Utente.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
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


  @override
  Widget build(BuildContext context) {
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
                            "35",
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
                  Cont1(Colors.red, Icons.auto_graph, "Voti"),
                  SizedBox(width: 10.w),
                  Cont1(Colors.orange, Icons.no_accounts_sharp, "Assenze"),
                  SizedBox(width: 10.w),
                  Cont1(Colors.yellow, Icons.person_2_outlined, "Argomenti.dart"),
                  SizedBox(width: 10.w),
                  Cont1(Colors.green, Icons.edit, "   Note"),
                  SizedBox(width: 10.w),
                  Cont1(Colors.blue, Icons.edit, "Annotazioni"),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            SizedBox(height : 20.h),
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
          switch(currentIndex){
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
            // Do nothing since we're already on the home page
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

