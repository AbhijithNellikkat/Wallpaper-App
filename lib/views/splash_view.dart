import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/views/wallpaper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WallPaper(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                fit: BoxFit.cover,
                height: 350,
                width: 450,
                'assets/Animation - 1702028826886.json'),
            Text(
              "Explore Set Enjoy 😊 ",
              style: GoogleFonts.poppins(
                  fontSize: 29,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
