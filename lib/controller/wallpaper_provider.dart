import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/wallpaper_model.dart';

class WallpaperProvider extends ChangeNotifier {
  List<WallpaperModel> images = [];
  int page = 1;

  Future<void> fetch() async {
    await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
      headers: {
        'Authorization': 'UqBEIzdrJL12mPl549KLIpzkTadsuBesR6gO4r9ISoG93pidEsOzLvg2',
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      List<WallpaperModel> wallpapers = [];

      for (var photo in result['photos']) {
        wallpapers.add(WallpaperModel.fromJson(photo));
      }

      images = wallpapers;
      notifyListeners();
    });
  }

  Future<void> loadMore() async {
    page++;
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';

    await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'UqBEIzdrJL12mPl549KLIpzkTadsuBesR6gO4r9ISoG93pidEsOzLvg2',
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      List<WallpaperModel> wallpapers = [];

      for (var photo in result['photos']) {
        wallpapers.add(WallpaperModel.fromJson(photo));
      }

      images.addAll(wallpapers);
      notifyListeners();
    });
  }
}
