class Album {
  final String title;
  final String imageUrl;
  Album(this.title, this.imageUrl);
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      json['title'],
      json['image'],
    );
  }
}
