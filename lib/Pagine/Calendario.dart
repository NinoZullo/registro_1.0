import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:registro/Pagine/HomePage.dart";
import "package:registro/Pagine/Profilo.dart";
import "package:registro/metodi/Metodi.dart";
import "package:registro/mysql/DBMetodi.dart";
import "package:registro/mysql/Utente.dart";
import "package:table_calendar/table_calendar.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

// PAGINA TERMINATA ED OTTIMIZZATA CON ANIMAZIONI ✅

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  late Map<DateTime, List<dynamic>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final int _selectedIndex = 0;
  final TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    fetchEventi();
  }

  List<dynamic> _getEventiDaGiorno(DateTime data) {
    return selectedEvents[data] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendario",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2025),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                format = format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventiDaGiorno,
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              selectedTextStyle: const TextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0.r),
                color: Colors.white,
              ),
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              outsideDaysVisible: true,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              formatButtonTextStyle: GoogleFonts.roboto(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0.sp,
              ),
            ),
          ),
          SizedBox(height: 10.0.sp),
          Expanded(
            child: eventi.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: eventi.length,
                    itemBuilder: (context, index) {
                      final evento = eventi[index];
                      final titolo = evento["nome_evento"] as String;
                      final descrizione = evento["descrizione"] as String;
                      final dataInizio = evento["data_inizio"] as DateTime;
                      final nomeClasse = evento["nome_classe"] as String;

                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0.w, horizontal: 20.0.h),
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
                            SizedBox(height: 5.0.h),
                            Text(
                              descrizione,
                              style: GoogleFonts.roboto(
                                  fontSize: 16.0.sp, color: Colors.black),
                            ),
                            SizedBox(height: 10.0.h),
                            Row(
                              children: [
                                Text(
                                  "Giorno: ${DateFormat("hh-dd-MM-yyyy").format(dataInizio)}",
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
                    },
                  ),
          ),
        ],
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
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const profilo(),
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
