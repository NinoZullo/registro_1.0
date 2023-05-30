import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:registro/Palette/Palette.dart';
import 'package:intl/intl.dart';


double _headerHeight = 50.0.h;
BottomNavigationBarItem It(String title, IconData icon) {
  return BottomNavigationBarItem(
    icon: Icon(icon),

    label: title,
  );
}

Widget Cont1(Color circleColor, IconData icon, String text) {
  return Container(
    width: 115.w,
    height: 170.h,
    decoration: BoxDecoration(
      color: azzurrino,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: blu1,
        width: 2.w,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 5.w,
          top: 5.h,
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
            child: Icon(icon, size: 20.w, color: Colors.white),
          ),
        ),
        Positioned(
          left: 37.w,
          top: 10.h,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Cont2(String text) {
  return Container(
    width: double.infinity,
    height: 100.h,
    decoration: BoxDecoration(
      color: azzurrino,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: blu1,
        width: 2.w,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 37.w,
          top: 10.h,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Cont3(String testo1) {
  return Container(
    width: 20.w,
    height: 100.h,
    decoration: BoxDecoration(
      color: azzurrino,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: blu1,
        width: 2.w,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 10.w,
          top: 10.h,
          child: Text(
            testo1,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget CustomButton(
    BuildContext context, Color color, String text, Widget destination) {
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
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ButtonSVG(
  BuildContext context,
  Color color,
  String text,
  Widget destination,
  String svgPath,
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
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0.w,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10.h,
            left: 5.w,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 19.0.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 15.w,
            top: 10.h,
            child: Container(
              width: 40.0.w,
              height: 100.0.h,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: SvgPicture.asset(
                      svgPath,
                      width: 72.0.w,
                      height: 72.0.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ContainerArgomenti({
  required String lessonTitle,
  required String lessonDate,
  required String lessonDescription,
  Color? color,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 10.w,
      right: 10.w,
      top: 10.h,
      bottom: 10.h,
    ),
    child: Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: color ?? Colors.lightGreenAccent,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0.w,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Row(
              children: [
                Text(
                  lessonTitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  lessonDate,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            lessonDescription,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget IconaD(String nomeDocente, String Ruolo) {
  return Column(
    children: [
      CircleAvatar(
        radius: 40.r,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.person,
          size: 50.sp,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        nomeDocente,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 5.h),
      Text(
        Ruolo,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget Prof(String testo1, String testo2) {
  return Padding(
    padding: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              testo1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  testo2,
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
  );
}

Widget ContainerVoti({
  required double Voto,
  required DateTime Data,
  required String Descrizione,
  Color? color,
}) {
  final formattedDate = DateFormat('yyyy-MM-dd').format(Data);
  final tipoVoto = Descrizione == 'Pratico'
      ? 'Pratico'
      : Descrizione == 'Scritto'
      ? 'Scritto'
      : 'Orale';

  return Padding(
    padding: EdgeInsets.only(
      left: 10.w,
      right: 10.w,
      top: 10.h,
      bottom: 10.h,
    ),
    child: Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: color ?? Colors.lightGreenAccent,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0.w,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Row(
              children: [
                Text(
                  "$Voto",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  "$formattedDate",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 10.h),
          Text(
            tipoVoto,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget Clas(
    BuildContext context,
    Color color,
    String nomeClasse,
    String nomeMateria,
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
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0.w,
        ),
      ),
      padding: EdgeInsets.all(10.0.w),
      child: Stack(
        children: [
          Positioned(
            top: 10.h,
            left: 5.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nomeClasse,
                  style: TextStyle(
                    fontSize: 19.0.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  nomeMateria,
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
