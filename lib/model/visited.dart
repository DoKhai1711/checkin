class Visited {
  String? username;
  String? address;
  String? createDate;
  int? money;
  String? name;
  String? phone;
  int? score;

  Visited({
    this.username,
    this.address,
    this.createDate,
    this.money,
    this.name,
    this.phone,
    this.score,
  });

  Visited.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    address = json['address'];
    createDate = json['createDate'];
    money = json['money'];
    name = json['name'];
    phone = json['phone'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['address'] = address;
    data['createDate'] = createDate;
    data['money'] = money;
    data['name'] = name;
    data['phone'] = phone;
    data['score'] = score;
    return data;
  }
}
