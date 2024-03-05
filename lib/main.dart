import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixclone/Screens/splashActivity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix-clone',
      theme: ThemeData(
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white, fontSize: 24),
            bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
          ),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
              .copyWith(background: Colors.black)),
      home: SplashScreen(),
    );
  }
}
