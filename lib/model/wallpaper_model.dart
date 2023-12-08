class WallpaperModel {
  final String imageUrl;
  final String photographer;
  final String photographerUrl;

  WallpaperModel({
    required this.imageUrl,
    required this.photographer,
    required this.photographerUrl,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
      imageUrl: json['src']['tiny'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
    );
  }
}
