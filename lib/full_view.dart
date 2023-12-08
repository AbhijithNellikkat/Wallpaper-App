// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FullView extends StatefulWidget {
  final String imageUrl;

  const FullView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<FullView> createState() => _FullViewState();
}

class _FullViewState extends State<FullView> {
  Future<void> setWallpaper() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl));
      final Uint8List bytes = response.bodyBytes;

      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/wallpaper.jpg');
      await file.writeAsBytes(bytes);
      print(file.path);

      WallpaperManager.setWallpaperFromFile(
              file.path, WallpaperManager.HOME_SCREEN)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
          
            content: Text('Wallpaper set successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  setWallpaper();
                },
                child: const Text(
                  'Set Wallpaper',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
