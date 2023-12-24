class SocialUserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVer;
  String? image;
  String? bio;
  String? cover;
  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVer,
    this.image,
    this.bio,
    this.cover,
});
  SocialUserModel.fromJson(Map<String,dynamic> json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    isEmailVer=json['isEmailVer'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];

  }
  Map<String,dynamic>toMap()
  {
    return{
     'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVer':isEmailVer,
      'image':image,
      'bio':bio,
      'cover':cover,
    };
  }
}