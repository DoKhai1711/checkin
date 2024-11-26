class LoginDto {
  int? id;
  String? username;
  String? email;

  LoginDto({this.id, this.username, this.email});

  LoginDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
