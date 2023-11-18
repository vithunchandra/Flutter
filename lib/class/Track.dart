class Track{
  final String name;
  final String url;
  final int duration;
  final String image;
  final int listeners;
  final int playcount;

  Track({
    required this.name,
    required this.playcount,
    required this.duration,
    required this.image,
    required this.listeners,
    required this.url
  });

  factory Track.fromJson(Map<String, dynamic> parsedJson){
    int duration = int.parse(parsedJson['duration']);
    int listeners = int.parse(parsedJson['listeners']);
    int playcount = int.parse(parsedJson['playcount']);
    String image = parsedJson['album'] != null ? parsedJson['album']['image'][2]['#text'] : '';

    return Track(
        name: parsedJson['name'],
        playcount: playcount,
        duration: duration,
        image: image,
        listeners: listeners,
        url: parsedJson['url']
    );
  }
}