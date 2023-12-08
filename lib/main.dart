import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/wallpaper.dart';

void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => WallpaperProvider(),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallPaper App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WallPaper(),
    );
  }
}
