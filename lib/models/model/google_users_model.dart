
class GoogleUser {
  String? id;
  String? displayName;
  String? email;
  String? photoUrl;

  GoogleUser({
    this.id,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      photoUrl: json['photoUrl'],
    );
  }
}
