import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../mysql/Utente.dart';
import '../PaginaLogin.dart';
import 'AssistenteDocenti.dart';
import 'Classi.dart';

class HomePageDocenti extends StatefulWidget {
  const HomePageDocenti({Key? key}) : super(key: key);

  @override
  _HomePageDocentiState createState() => _HomePageDocentiState();
}

class _HomePageDocentiState extends State<HomePageDocenti> {
  final int _selectedIndex = 1;

  final List<NewsArticle> newsArticles = [
    NewsArticle(
      title: 'Guerra ucraina',
      content: 'Cremlino: Pronti al dialogo con gli Usa',
    ),
    NewsArticle(
      title: 'Omicidio Giulia Tramontano',
      content: 'Omicidio Giulia Tramontano, il difensore di Impagnatiello rinuncia al mandato',
    ),
    NewsArticle(
      title: 'Covid 19',
      content: "Una catena umana tra Bergamo e Brescia, l'unione simbolica dei cittadini a tre anni dal Covid19",
    ),
  ];

  final List<Resource> resources = [
    Resource(
      title: 'Corso JavaScript',
      description: 'Corso per imparare JavaScript',
      url: 'https://youtu.be/W6NZfCO5SIk',
    ),
    Resource(
      title: 'Corso C',
      description: 'Corso per imparare il linguaggio C',
      url: 'https://youtu.be/KJgsSFOSQv0',
    ),
    Resource(
      title: 'Corso java Swing',
      description: 'Corso Java swing',
      url: 'https://www.youtube.com/live/6zm8c6QFmjo?feature=share',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
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
        padding: EdgeInsets.only(top: 30.0.h, left: 10.0.w, right: 10.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person, size: 40.0.sp),
                  SizedBox(width: 10.0.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$nome_ $cognome_',
                        style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Docente',
                        style: GoogleFonts.roboto(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0.h),
              SizedBox(height: 10.0.h),
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.cyan.shade200,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'News',
                        style: GoogleFonts.roboto(
                          fontSize: 20.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0.h),
                      Expanded(
                        child: ListView.builder(
                          itemCount: newsArticles.length,
                          itemBuilder: (context, index) {
                            final article = newsArticles[index];
                            return ListTile(
                              title: Text(
                                article.title,
                                style: GoogleFonts.roboto(
                                  fontSize: 16.0.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                article.content,
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0.sp,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0.h),
              Text(
                'Risorse per approfondimento',
                style: GoogleFonts.roboto(
                  fontSize: 20.0.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: resources
                    .map((resource) => buildResourceContainer(resource))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Classi',
            icon: Icon(Icons.people_alt_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Assistente',
            icon: Icon(Icons.help),
          ),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Classi(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssistenteDocenti(),
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

  Widget buildResourceContainer(Resource resource) {
    return GestureDetector(
      onTap: () {
        // ignore: deprecated_member_use
        launch(resource.url);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0.w),
        margin: EdgeInsets.only(bottom: 16.0.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource.title,
              style: GoogleFonts.roboto(
                fontSize: 16.0.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0.h),
            Text(
              resource.description,
              style: GoogleFonts.roboto(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsArticle {
  final String title;
  final String content;

  NewsArticle({required this.title, required this.content});
}

class Resource {
  final String title;
  final String description;
  final String url;

  Resource({required this.title, required this.description, required this.url});
}
