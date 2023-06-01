import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/Pagine/Annotazioni.dart";
import "package:registro/Pagine/Argomenti.dart";
import "package:registro/Pagine/Assenze.dart";
import "package:registro/Pagine/Calendario.dart";
import "package:registro/Pagine/Compiti.dart";
import "package:registro/Pagine/NoteDisciplinari.dart";
import "package:registro/Pagine/Profilo.dart";
import "package:registro/Pagine/Voti.dart";
import "package:registro/metodi/Metodi.dart";
import "package:registro/Pagine/PaginaLogin.dart";
import "package:registro/mysql/Utente.dart";
import "package:day_night_switcher/day_night_switcher.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 1;
  bool _isDarkMode = false;

  

  void _toggleTheme() {
    setState(() {
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
        title: Text("Home Page" , style: GoogleFonts.roboto(color: Colors.white, fontSize: 18.sp , fontWeight: FontWeight.bold)),
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
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const PaginaLogin(),
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
                        MaterialPageRoute(builder: (context) => const Voti()),
                      );
                    },
                    child: const Cont1(Colors.red, Icons.auto_graph, "Voti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Assenze()),
                      );
                    },
                    child: const Cont1(Colors.orange, Icons.no_accounts_sharp, "Assenze"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Compiti()),
                      );
                    },
                    child: const Cont1(Colors.yellow, Icons.person_2_outlined, "Compiti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NoteDisciplinari()),
                      );
                    },
                    child: const Cont1(Colors.green, Icons.beenhere_sharp, "Note"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Argomenti()),
                      );
                    },
                    child: const Cont1(Colors.blue, Icons.edit, "Argomenti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Annotazioni()),
                      );
                    },
                    child: const Cont1(Colors.purple, Icons.account_balance, "Annotaz."),
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
                  SizedBox(height: 5.h),
                  Cont2("Verifica di matematica"),
                  SizedBox(height: 5.h),
                  Cont2("Uscita didattica"),
                  SizedBox(height: 5.h),
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
          It("Home", Icons.home),
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
              case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profilo(),
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

  const Cont1(this.color, this.icon, this.text, {super.key});

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