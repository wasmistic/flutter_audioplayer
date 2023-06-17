class Song{
  String title;
  String description;
  String url;
  String coverUrl;

  Song({required this.title,required this.description,required this.url, required this.coverUrl});

  static List<Song> generateSongs = [
    Song(
      title: 'Afrobeat',
      description: 'Afro song',
      url: 'music/glass.mp3',
      coverUrl: 'assets/images/glass.jpg',
    ),
    Song(
      title: 'Afro Live',
      description: 'Afro stage',
      url: 'music/illusions.mp3',
      coverUrl: 'assets/images/illusions.jpg',
    ),
    Song(
      title: 'Pray',
      description: 'Pray',
      url: 'music/pray.mp3',
      coverUrl: 'assets/images/pray.jpg',
    )
  ];
}