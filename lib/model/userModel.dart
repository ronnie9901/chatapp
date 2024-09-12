

class UserModel{

  String?  name  ,email, img,phone,token;

  UserModel(this.name, this.email, this.img, this.phone, this.token);



  factory  UserModel.fromMap( Map m1){

    return  UserModel(m1['name'], m1['email'], m1['img'], m1['phone'], m1['token']);

  }

  Map<String, String?> toMap (UserModel  user){

    return  {
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'img': user.img,
      'token': user.token,

    };
  }
}