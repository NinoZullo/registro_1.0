import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/Pagine/Docenti/HomePageDocenti.dart';
import 'package:registro/Pagine/Docenti/OrarioDocenti.dart';
import 'package:registro/Pagine/Docenti/SelectedClass.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/metodi/Metodi.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Mysql.dart';
import 'package:registro/mysql/utente.dart';

class Classi extends StatefulWidget {
  const Classi({Key? key}) : super(key: key);

  @override
  State<Classi> createState() => _ClassiState();
}

class _ClassiState extends State<Classi> {
  int _selectedIndex = 0;
  final double _headerHeight = 100.h;
  final EdgeInsetsGeometry _rowPadding =
  EdgeInsets.only(top: 30.h, left: 15.h, right: 10.h);

  List<Map<String, dynamic>> classList = [];

  @override
  void initState() {
    super.initState();
    fetchClassi();
  }

  Future<void> fetchClassi() async {
    try {
      List<Map<String, dynamic>>? classListData = await getClassi(idUtente_!);
      if (classListData != null) {
        setState(() {
          classList = classListData ?? [];
        });
      }
    } catch (e) {
      print("Errore");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Classi Docente",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
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
                  backgroundColor: Colors.deepPurple,
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
            "Benvenuto!",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Professore',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: classList.length,
              itemBuilder: (BuildContext context, int index) {
                final nomeMateria = classList[index]['nome_materia'];
                final className = classList[index]['nome_classe'];
                print('Class: $className');
                print('Subject: $nomeMateria');
                return Padding(
                  padding: _rowPadding,
                  child: ButtonSVG(
                    context,
                    Colors.white,
                    className,
                    SelectedClass(className: className, nome_materia: nomeMateria),
                    'assets',
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
          It("Classi", Icons.people_alt_rounded),
          It("Home", Icons.home),
          It("Orari", Icons.lock_clock),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Classi(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageDocenti(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrarioDocenti(),
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
