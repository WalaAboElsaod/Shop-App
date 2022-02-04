class ShopUserModel {
  late bool status;
   String? message;
  LoginUserData? data;
  ShopUserModel(this.status,this.message,this.data);

 factory ShopUserModel.fromJason(Map<String, dynamic> json) {
   return ShopUserModel ( json['status'],

     json['message'],
     json['data'] != null ? LoginUserData.fromJason(json['data']) : null);
  }
}

class LoginUserData{
  int? id;
  String? name;
  String? email;
  String? phone;

  String? image;
  int? points;
  int? credit;
  String? token;

//named constructor

  LoginUserData.fromJason(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    token = json['token'];
  }
}
