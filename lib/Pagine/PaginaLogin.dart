/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */
import 'package:mysql1/mysql1.dart' as mysql;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/Pagine/Docenti/HomePageDocenti.dart';
import 'package:registro/Pagine/HomePage.dart';
import 'package:registro/Pagine/PasswordDimenticata.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/Palette/Palette.dart';
import 'package:registro/Pagine/Registrati.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';
class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);
  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  DBMetodi db = DBMetodi();

  bool _rememberMe = false;
  TextEditingController nomeCognomeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color emailTextColor = Colors.grey;
  double _headerHeight = 100.h;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 90.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0.w),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0.w, top: 5),
                      child: Center(
                        child: Text(
                          'Log in',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 40.0.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.h),
                  SizedBox(
                    height: 40.0.h,
                    child: TextField(
                      controller: nomeCognomeController,
                      decoration: InputDecoration(
                        hintText: 'Nome utente',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                          borderSide: BorderSide(
                            color: Colors.white10,
                            width: 2.0.w,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0.w, horizontal: 15.0.h),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0.w,
                          ),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 40.0.h,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                          borderSide: BorderSide(
                            color: Colors.white10,
                            width: 2.0.w,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0.w, horizontal: 15.0.h),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0.w,
                          ),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 60.h),
                  CheckboxListTile(
                    title: Text(
                      'Ricordami',
                      style: GoogleFonts.roboto(
                        fontSize: 15.w,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    value: _rememberMe,
                    onChanged: (newValue) {
                      setState(() {
                        _rememberMe = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                        bool isLoggedIn =
                        await db.login(
                          nomeCognomeController.text,
                          passwordController.text,
                        );
                        if (isLoggedIn&& isStudente_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }else if(isLoggedIn&& !isStudente_){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageDocenti(),
                            ),
                          );
                        }else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Errore di accesso"),

                                content: Text("Le credenziali di accesso sono errate.", style: TextStyle(color: Colors.red),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: coloreStile,
                        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.w, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PasswordDimenticata(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 150.w),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registrati(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
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
    );
  }


}

