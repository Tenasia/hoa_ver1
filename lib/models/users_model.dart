
// Class or model we had this in spring, it's similar to it (which is also a java language)
// Here we make a factory that makes it so that the parameters inside the Emailuser is accessible via their keys

class EmailUser{
  int? id;
  String? token;
  String? username;
  String? password;
  String? email, first_name, middle_name, last_name;


  EmailUser({
    this.email,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.password,
    this.id,
    this.username,
  });

  factory EmailUser.fromJson(json){

    return EmailUser(
      id: json["pk"],
      email: json["email"],
      first_name: json["first_name"],
      middle_name: json["middle_name"],
      last_name: json["last_name"],
    );
  }

}