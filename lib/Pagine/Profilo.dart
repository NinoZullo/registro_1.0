import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";

import "../Palette/Palette.dart";
import "../metodi/Metodi.dart";
import "../mysql/Utente.dart";
import "Widget/HeaderHeight.dart";

//Pagina terminata ed Ottimizzata ✅

class Profilo extends StatefulWidget {
  const Profilo({Key? key}) : super(key: key);

  @override
  State<Profilo> createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {
  int calcolaEta(DateTime dataDiNascita) {
    DateTime dataCorrente = DateTime.now();
    int eta = dataCorrente.year - dataDiNascita.year;
    if (dataCorrente.month < dataDiNascita.month ||
        (dataCorrente.month == dataDiNascita.month &&
            dataCorrente.day < dataDiNascita.day)) {
      eta--;
    }
    return eta;
  }

  final double _headerHeight = 100.h;
  final bool isAttive = false;
  final bool isChecked = false;
  final bool isDarkMode = false;

  late File _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = File("");
  }

  Widget customButton(
    BuildContext context,
    Color color,
    String text,
    Function() onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
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
                    stops: const [0.0, 1.0],
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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: Text(
                  "Scatta una foto",
                  style: GoogleFonts.roboto(
                      color: Colors.grey[700], fontSize: 18.sp),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(
                  "Scegli dalla galleria",
                  style: GoogleFonts.roboto(
                      color: Colors.grey[700], fontSize: 18.sp),
                ),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    backgroundColor: blu1,
                    child: _selectedImage.path.isNotEmpty
                        ? Image.file(
                            _selectedImage,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 50.sp,
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "$nome_ $cognome_",
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Studente",
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
                        Prof("Nome", nome_),
                        SizedBox(height: 20.h),
                        Prof("Cognome", cognome_),
                        SizedBox(height: 20.h),
                        Prof("Classe", "$classe_"),
                        SizedBox(height: 20.h),
                        Prof("Età", calcolaEta(dataDiNascita_!).toString()),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 20.h),
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
                                        DateFormat("dd/MM/yyyy")
                                            .format(dataDiNascita_!),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showImagePicker,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
