class AppUser {
  String? userName;
  String? email;
  String? imageUrl;

  AppUser(String userName, String email, String imageUrl) {
    this.email = email;
    this.userName = userName;
    this.imageUrl = imageUrl;
  }
  AppUser.fromMap(Map<String, dynamic> map) {
    this.email = map["email"];
    this.userName = map["userName"];
    this.imageUrl = map["imageUrl"];
  }
  toMap() {
    return {
      ["email"]: email,
      ["userName"]: userName,
      ["imageUrl"]: imageUrl
    };
  }
}
