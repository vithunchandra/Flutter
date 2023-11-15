class Album{
  final String name;
  final int playcount;
  final String url;
  final String image;

  Album({
    required this.name,
    required this.url,
    required this.image,
    required this.playcount
  });

  factory Album.fromJson(Map<String, dynamic> parsedJson){
    return Album(
        name: parsedJson['name'],
        url: parsedJson['url'],
        image: parsedJson['image'][2]['#text'],
        playcount: parsedJson['playcount']
    );
  }
}