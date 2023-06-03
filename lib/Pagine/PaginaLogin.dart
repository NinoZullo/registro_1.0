import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";
import "package:rive/rive.dart";

import "../mysql/Utente.dart";
import "Docenti/HomePageDocenti.dart";
import "HomePage.dart";
import "Widget/HeaderHeight.dart";

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  var nomeCognomeController = TextEditingController();
  var passwordController = TextEditingController();

  var animationLink = "assets/login.riv";
  late SMITrigger failTrigger, successTrigger;
  late SMIBool isChecking, isHandsUp;
  late SMINumber lookNum;
  Artboard? artboard;
  late StateMachineController? stateMachineController;

  bool _isLoading = false;
  DBMetodi db = DBMetodi();
  bool _passwordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    initArtboard();
  }

  initArtboard() {
    rootBundle.load(animationLink).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, "Login Machine");
      if (stateMachineController != null) {
        art.addController(stateMachineController!);
        for (var element in stateMachineController!.inputs) {
          if (element.name == "isChecking") {
            isChecking = element as SMIBool;
          } else if (element.name == "isHandsUp") {
            isHandsUp = element as SMIBool;
          } else if (element.name == "trigSuccess") {
            successTrigger = element as SMITrigger;
          } else if (element.name == "trigFail") {
            failTrigger = element as SMITrigger;
          } else if (element.name == "numLook") {
            lookNum = element as SMINumber;
          }
        }
      }
      setState(() {
        artboard = art;
      });
    });
  }

  checking() {
    isHandsUp.change(false);
    isChecking.change(true);
    lookNum.change(0);
  }

  moveEyes(value) {
    lookNum.change(value.length.toDouble());
  }

  handsUp() {
    isHandsUp.change(true);
    isChecking.change(false);
  }

  handsDown() {
    isHandsUp.change(false);
    isChecking.change(false);
  }

  void togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });

    isHandsUp.change(false);
    isChecking.change(false);
    bool isLoggedIn = await db.login(
      nomeCognomeController.text,
      passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (isLoggedIn && isStudente_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else if (isLoggedIn && !isStudente_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePageDocenti(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text(
              "Accesso non riuscito",
              style: GoogleFonts.roboto(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            content:  Text(
              "Le credenziali di accesso inserite non sono corrette.",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:  Text(
                  "OK",
                  style: GoogleFonts.roboto(
                    color: Colors.blue,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  final double _headerHeight = 100.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd6e2ea),
      body: Column(
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (artboard != null)
                    SizedBox(
                      width: 300.w,
                      height: 250.h,
                      child: Rive(artboard: artboard!),
                    ),
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    padding: const EdgeInsets.only(bottom: 15),
                    margin: const EdgeInsets.only(bottom: 15 * 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 15 * 2),
                          TextField(
                            onTap: checking,
                            onChanged: moveEyes,
                            controller: nomeCognomeController,
                            style: GoogleFonts.roboto(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: const Color(0xffd6e2ea),
                              filled: true,
                              hintText: "Username",
                              prefixIcon: const Icon(Icons.person),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15 * 2),
                          TextField(
                            onTap: handsUp,
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            style:  GoogleFonts.roboto(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: const Color(0xffd6e2ea),
                              filled: true,
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              suffixIcon: GestureDetector(
                                onTap: togglePasswordVisibility,
                                child: Icon(
                                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15 * 2),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                               Text(
                                "Remember me",
                                style: GoogleFonts.roboto(fontSize: 16.sp , color: Colors.black),
                              ),
                      SizedBox(width: 50.w,),
                              ElevatedButton(
                                onPressed: login,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.blue,
                                  ),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    :  Text(
                                  "LOGIN",
                                  style: GoogleFonts.roboto(fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15 * 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
