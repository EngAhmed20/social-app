class PostModel
{
  String? name;
  String? image;
  String? uId;
  String? dateTime;
  String? text;
  String? PostImage;
  PostModel({this.name,
    this.dateTime,
    this.uId,
    this.text,
    this.PostImage,
    this.image,
  });
  PostModel.fromJson(Map<String,dynamic>json)
  {
    dateTime = json['dateTime'];
    image = json['image'];
    name = json['name'];
    text = json['text'];
    uId = json['uId'];
    PostImage = json['PostImage'];
  }
  Map<String,dynamic >toMap()
  {
    return
      {
        'name':name,
        'text':text,
        'image':image,
        'dateTime':dateTime,
        'PostImage':PostImage,
        'uId':uId,


      };
  }

}