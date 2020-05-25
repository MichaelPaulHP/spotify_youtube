class User {
  final String country;
  final String displayName;
  final String email;
  final String externalUrls;
  final int followers;
  final String href;
  final String id;
  final String imageUrl;
  final String product;
  final String type;
  final String uri;

  User({this.country, this.displayName, this.email, this.externalUrls,
      this.followers, this.href, this.id, this.imageUrl, this.product, this.type,
      this.uri});

  factory User.getFromJson(Map<String,dynamic> json){
    return User(
      country: json["country"] as String,
      displayName: json["display_name"] as String,
      email: json["email"] as String,
      //externalUrls: json["external_urls"] as String,
      //followers: json["followers"]["total"] as int,
      href: json["href"] as String,
      id: json["id"] as String,
      imageUrl: json["images"][0]["url"] as String,
      product: json["product"] as String,
      type: json["type"] as String,
      uri: json["uri"] as String,
    );

  }

  @override
  String toString() {
    return 'User{country: $country, displayName: $displayName, email: $email, externalUrls: $externalUrls, followers: $followers, href: $href, id: $id, imageUrl: $imageUrl, product: $product, type: $type, uri: $uri}';
  }

}