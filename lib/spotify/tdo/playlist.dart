class Playlist {
  final String description;
  final String href;
  final String id;
  final List<String> imagesUrls;
  final String name;
  final String owner;
  final String uri;
  final String tracksHref;

  final int tracksTotal;

  final String tracksUri;

  final bool isOwn;

  Playlist(
      {this.description,
      this.href,
      this.id,
      this.imagesUrls,
      this.name,
      this.owner,
      this.uri,
      this.tracksHref,
      this.tracksTotal,
      this.tracksUri,
      this.isOwn = false});

  static Playlist fromJson(Map<String, dynamic> json) {
    return Playlist(
      description: json["description"] as String,
      href: json["href"] as String,
      id: json["id"] as String,
      imagesUrls: _getImagesFromJson(json["images"]),
      name: json["name"] as String,
      owner: json["owner"]["display_name"] as String,
      uri: json["uri"] as String,
      tracksHref: json["tracks"]["href"] as String,
      tracksTotal: json["tracks"]["total"] as int,
      tracksUri: json["tracks"]["uri"] as String,
    );
  }

  static List<String> _getImagesFromJson(List<dynamic> images) {
    List<dynamic> imagesUrls = List<String>();
    if (images.isNotEmpty) {
      images.forEach((element) {
        imagesUrls.add(element["url"]);
      });
    }
    return imagesUrls;
  }
}

class MyTracksSaved extends Playlist {
  MyTracksSaved()
      : super(
          description: "Liked songs ",
          href: "",
          id: "1",
          imagesUrls: ["https://cdn.pixabay.com/photo/2016/02/10/21/57/heart-1192662_960_720.jpg"],
          name: "Songs you like",
          owner: "own",
          uri: "",
          tracksHref: "",
          tracksTotal: 15,
          tracksUri: " ",
        );
}

class RecentlyPlayed extends Playlist {
  RecentlyPlayed()
      : super(
          description: "Recently played",
          href: "",
          id: "1",
          imagesUrls: ["https://cdn.pixabay.com/photo/2018/06/10/20/05/lavender-3467202_960_720.jpg"],
          name: "RecentlyPlayed",
          owner: "own",
          uri: "",
          tracksHref: "",
          tracksTotal: 15,
          tracksUri: " ",
        );
}
