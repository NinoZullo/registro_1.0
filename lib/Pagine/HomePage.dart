import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:registro/Pagine/Annotazioni.dart";
import "package:registro/Pagine/Argomenti.dart";
import "package:registro/Pagine/Assenze.dart";
import "package:registro/Pagine/AssistenteStudenti.dart";
import "package:registro/Pagine/Calendario.dart";
import "package:registro/Pagine/Compiti.dart";
import "package:registro/Pagine/NoteDisciplinari.dart";
import "package:registro/Pagine/Profilo.dart";
import "package:registro/Pagine/Voti.dart";
import "package:registro/metodi/Metodi.dart";
import "package:registro/Pagine/PaginaLogin.dart";
import "package:registro/mysql/DBMetodi.dart";
import "package:registro/mysql/Utente.dart";
import "package:day_night_switcher/day_night_switcher.dart";

//Pagina terminata ed Ottimizzata ✅

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
    setState(() {});
  }

  int calculateRemainingDays() {
    final now = DateTime.now();
    final targetDate = DateTime(now.year, 6, 8);
    final difference = targetDate.difference(now);
    return difference.inDays;
  }

  @override
  void initState() {
    super.initState();
    fetchEventi();
  }

  DBMetodi db = DBMetodi();
  List<Map<String, dynamic>> eventi = [];

  Future<void> fetchEventi() async {
    final fetchedEventi = await db.getEventi(idClasse_!);
    setState(() {
      eventi = fetchedEventi ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    int remainingDays = calculateRemainingDays();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page",
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold)),
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
                  builder: (context) => const PaginaLogin(),
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
                Icon(Icons.person_off, size: 40.w),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$nome_ $cognome_",
                      style: GoogleFonts.roboto(
                          fontSize: 20.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Studente",
                      style: GoogleFonts.roboto(
                          fontSize: 16.w, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(width: 65.w),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profilo()),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Text(
                          "Profilo",
                          style: GoogleFonts.roboto(
                            fontSize: 14.w,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          style: GoogleFonts.roboto(
                              fontSize: 15.w, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 25.w),
                          child: Text(
                            "0",
                            style: GoogleFonts.roboto(
                                fontSize: 15.w, color: Colors.black),
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
                          style: GoogleFonts.roboto(
                              fontSize: 15.w, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 23.w),
                          child: Text(
                            "3",
                            style: GoogleFonts.roboto(
                                fontSize: 15.w, color: Colors.black),
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
                          style: GoogleFonts.roboto(
                              fontSize: 14.w, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 50.w),
                          child: Text(
                            "$remainingDays",
                            style: GoogleFonts.roboto(
                                fontSize: 15.w, color: Colors.black),
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
                        MaterialPageRoute(
                            builder: (context) => const Assenze()),
                      );
                    },
                    child: const Cont1(
                        Colors.orange, Icons.no_accounts_sharp, "Assenze"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Compiti()),
                      );
                    },
                    child: const Cont1(
                        Colors.yellow, Icons.person_2_outlined, "Compiti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NoteDisciplinari()),
                      );
                    },
                    child:
                        const Cont1(Colors.green, Icons.beenhere_sharp, "Note"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Argomenti()),
                      );
                    },
                    child: const Cont1(Colors.blue, Icons.edit, "Argomenti"),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Annotazioni()),
                      );
                    },
                    child: const Cont1(
                        Colors.purple, Icons.account_balance, "Annotazioni"),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                  itemCount: eventi.length,
                  itemBuilder: (context, index) {
                    final evento = eventi[index];
                    final titolo = evento["nome_evento"] as String;
                    final dataInizio = evento["data_inizio"] as DateTime;
                    final nomeClasse = evento["nome_classe"] as String;
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0.w, horizontal: 10.0.h),
                      padding: EdgeInsets.all(15.0.w),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titolo,
                            style: GoogleFonts.roboto(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          Row(
                            children: [
                              Text(
                                "Giorno: ${DateFormat("hh dd-MM-yyyy").format(dataInizio)}",
                                style: GoogleFonts.roboto(
                                    fontSize: 16.0.sp, color: Colors.black),
                              ),
                              SizedBox(width: 10.0.w),
                            ],
                          ),
                          SizedBox(height: 5.0.h),
                          Text(
                            "Nome classe: $nomeClasse",
                            style: GoogleFonts.roboto(
                                fontSize: 16.0.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          It("Calendario", Icons.calendar_month),
          It("Home", Icons.home),
          It("Assistente", Icons.help),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Calendario(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssistenteStudenti(),
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
      width: 130.w,
      height: 110.h,
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
            style: GoogleFonts.roboto(fontSize: 14.w, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
