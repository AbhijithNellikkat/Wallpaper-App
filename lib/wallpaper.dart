// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/full_view.dart';

class WallPaper extends StatefulWidget {
  const WallPaper({super.key});

  @override
  State<WallPaper> createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              'UqBEIzdrJL12mPl549KLIpzkTadsuBesR6gO4r9ISoG93pidEsOzLvg2'
        }).then((value) {
      Map result = jsonDecode(value.body);

      setState(() {
        images = result['photos'];
      });
    });
  }

  Future<void> loadMore() async {
    setState(() {
      page = page + 1;
    });

    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'UqBEIzdrJL12mPl549KLIpzkTadsuBesR6gO4r9ISoG93pidEsOzLvg2'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullView(
                              imageUrl: images[index]['src']['large2x']),
                        ));
                  },
                  child: Container(
                    color: Colors.black,
                    child: Image.network(
                      images[index]['src']['tiny'],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              loadMore();
            },
            child: const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Text(
                'Load More',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
